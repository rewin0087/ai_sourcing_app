class FuelixService
  API_URL = ENV.fetch("FUELIX_API_URL", "https://api.fuelix.ai")
  API_KEY = ENV.fetch("FUELIX_API_KEY", "")
  DEFAULT_MODEL = "claude-sonnet-4-6"

  def initialize
    @conn = Faraday.new(url: API_URL) do |f|
      f.request :json
      f.response :json
      f.options.open_timeout = 30
      f.options.timeout = 120
      f.adapter Faraday.default_adapter
    end
  end

  def complete(prompt, model: DEFAULT_MODEL, temperature: 0.7, max_tokens: 4096, timeout: 120)
    Rails.logger.info("[FuelixService] REQUEST model=#{model} max_tokens=#{max_tokens} timeout=#{timeout} prompt_length=#{prompt.length}")
    Rails.logger.debug("[FuelixService] PROMPT #{prompt}")

    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    response = @conn.post("/v1/chat/completions") do |req|
      req.headers["Authorization"] = "Bearer #{API_KEY}"
      req.headers["Content-Type"] = "application/json"
      req.options.timeout = timeout
      req.body = {
        model: model,
        messages: [{ role: "user", content: prompt }],
        temperature: temperature,
        max_tokens: max_tokens
      }
    end

    elapsed = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at).round(2)
    Rails.logger.info("[FuelixService] RESPONSE status=#{response.status} elapsed=#{elapsed}s")

    raise "FuelIX API error: #{response.status}" unless response.success?

    body = response.body
    finish_reason = body.dig("choices", 0, "finish_reason")
    usage = body.dig("usage")
    content = body.dig("choices", 0, "message", "content") ||
              body.dig("choices", 0, "text") ||
              raise("No content in FuelIX response")

    Rails.logger.info("[FuelixService] finish_reason=#{finish_reason} content_length=#{content.length} usage=#{usage.inspect}")
    Rails.logger.debug("[FuelixService] RESPONSE_BODY #{content}")
    Rails.logger.warn("[FuelixService] Response truncated by token limit") if finish_reason == "length"

    content
  end

  # Multi-turn chat with full messages array (supports system role)
  def chat_complete(messages, model: DEFAULT_MODEL, temperature: 0.7, max_tokens: 4096, timeout: 120)
    Rails.logger.info("[FuelixService] CHAT_REQUEST model=#{model} messages=#{messages.length}")
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    response = @conn.post("/v1/chat/completions") do |req|
      req.headers["Authorization"] = "Bearer #{API_KEY}"
      req.headers["Content-Type"] = "application/json"
      req.options.timeout = timeout
      req.body = {
        model: model,
        messages: messages,
        temperature: temperature,
        max_tokens: max_tokens
      }
    end

    elapsed = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at).round(2)
    Rails.logger.info("[FuelixService] CHAT_RESPONSE status=#{response.status} elapsed=#{elapsed}s")
    raise "FuelIX API error: #{response.status}" unless response.success?

    body = response.body
    body.dig("choices", 0, "message", "content") ||
      body.dig("choices", 0, "text") ||
      raise("No content in FuelIX response")
  end

  def extract_json(prompt, **opts)
    raw = complete(prompt, **opts, temperature: 0)
    cleaned = raw.gsub(/```json\s*/i, "").gsub(/```\s*$/, "").strip
    match = cleaned.match(/\{.*\}/m)
    raise "No JSON object found in response" unless match

    json_str = sanitize_ai_json(match[0])
    begin
      JSON.parse(json_str)
    rescue JSON::ParserError => e
      Rails.logger.warn("[FuelixService] JSON parse failed after sanitize (#{e.message}), attempting structural repair")
      repaired = repair_truncated_json(json_str)
      raise "AI returned invalid JSON and repair failed" if repaired.nil?
      repaired
    end
  end

  # Generate text embeddings using FuelIX embeddings endpoint
  # Falls back to a deterministic placeholder if not supported
  def embed(text, model: "text-embedding-ada-002")
    response = @conn.post("/v1/embeddings") do |req|
      req.headers["Authorization"] = "Bearer #{API_KEY}"
      req.headers["Content-Type"] = "application/json"
      req.options.timeout = 30
      req.body = { model: model, input: text.truncate(8000) }
    end

    if response.success?
      body = response.body
      embedding = body.dig("data", 0, "embedding")
      return embedding if embedding&.length == 1536
    end

    # Fallback: generate deterministic pseudo-embedding using text hash
    generate_fallback_embedding(text)
  rescue StandardError
    generate_fallback_embedding(text)
  end

  private

  def sanitize_ai_json(str)
    # AI sometimes emits "key">value instead of "key":value when the value
    # is numeric and the field name implies comparison (e.g. years_of_exp_in_months > 60).
    # Replace any `"key">number` with `"key":number`.
    str.gsub(/(\"[\w_]+\")\s*>\s*(\d)/, '\1:\2')
  end

  def repair_truncated_json(str)
    open_braces = 0
    open_brackets = 0
    in_string = false
    escape_next = false

    str.each_char do |ch|
      if escape_next
        escape_next = false
        next
      end
      case ch
      when "\\" then escape_next = true if in_string
      when '"'  then in_string = !in_string
      when "{"  then open_braces   += 1 unless in_string
      when "}"  then open_braces   -= 1 unless in_string
      when "["  then open_brackets += 1 unless in_string
      when "]"  then open_brackets -= 1 unless in_string
      end
    end

    repaired = str.rstrip
    repaired += '"'  if in_string
    open_brackets.times { repaired += "]" }
    open_braces.times   { repaired += "}" }

    JSON.parse(repaired)
  rescue JSON::ParserError
    nil
  end

  def generate_fallback_embedding(text)
    # Deterministic 1536-dim vector based on text content
    # Not semantically meaningful but allows the app to function
    srand(text.bytes.sum)
    Array.new(1536) { rand(-1.0..1.0) }.tap { srand }
  end
end
