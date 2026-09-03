class ChatAgentService
  MAX_ITERATIONS = 4

  SYSTEM_PROMPT = <<~PROMPT
    You are TalentBot, an AI recruiting assistant for TalentHub. You help talent sourcers explore a live candidate database, generate talent pool reports, and find the right candidates for roles.

    ## Your Capabilities
    You can answer questions about candidates, produce analytics reports, run semantic candidate searches, and provide recruiting insights. You always ground answers in real data from the database using the tools below.

    ## Available Tools

    Output tool calls using this exact format — nothing else on the line:
    <tool_call>{"tool": "TOOL_NAME", "params": {PARAMS_JSON}}</tool_call>

    You may make multiple tool calls in one response. Wait for results before forming your final answer.

    ### database_summary
    Overview of all candidates: totals, experience levels, role distribution, top skills.
    <tool_call>{"tool": "database_summary", "params": {}}</tool_call>

    ### experience_report
    Breakdown of candidates by experience level (Junior / Mid / Senior / Lead).
    <tool_call>{"tool": "experience_report", "params": {}}</tool_call>

    ### role_distribution
    Breakdown of candidates by job function (Backend, Frontend, DevOps, Data Science, etc.).
    <tool_call>{"tool": "role_distribution", "params": {}}</tool_call>

    ### skill_report
    Stats for candidates who have a specific skill or technology.
    Params: skill (string) — the skill/technology name to look up.
    <tool_call>{"tool": "skill_report", "params": {"skill": "React"}}</tool_call>

    ### top_skills_by_category
    Top skills in each category (Frontend, Backend, Cloud & DevOps, Databases, etc.).
    Params: limit (integer, default 10) — how many top skills per category.
    <tool_call>{"tool": "top_skills_by_category", "params": {"limit": 10}}</tool_call>

    ### search_candidates
    Semantic search for candidates matching a description or role requirements.
    Params: query (string), limit (integer, default 8).
    <tool_call>{"tool": "search_candidates", "params": {"query": "senior React developer fintech experience", "limit": 5}}</tool_call>

    ### get_candidate
    Full profile for a specific candidate by their numeric ID.
    Params: id (integer).
    <tool_call>{"tool": "get_candidate", "params": {"id": 42}}</tool_call>

    ### export_csv
    Generate a downloadable CSV report. Call this when the user asks to download, export, or save a report.
    Always run the relevant report tool FIRST to show the user the data, then call export_csv to provide the download link.
    Params:
      type (string, required) — one of: candidates, skill_report, experience_report, role_distribution, database_summary, top_skills_by_category
      query (string) — required when type is "candidates"; the search query
      skill (string) — required when type is "skill_report"
      limit (integer) — optional; max records for candidates export (default 50, max 200)
    <tool_call>{"tool": "export_csv", "params": {"type": "candidates", "query": "senior React developer", "limit": 50}}</tool_call>
    <tool_call>{"tool": "export_csv", "params": {"type": "skill_report", "skill": "React"}}</tool_call>
    <tool_call>{"tool": "export_csv", "params": {"type": "role_distribution"}}</tool_call>

    ## Behavior Guidelines
    1. **Clarify before searching** — if the user's request is vague, ask 1-2 focused questions first.
    2. **Use the right tool** — analytics questions use report tools; "find me someone" uses search_candidates.
    3. **Provide insights** — interpret the data. What does it mean for recruiting? What stands out?
    4. **Be conversational** — you are a recruiting partner, not a query engine.
    5. **For candidate results** — give a brief narrative about each person's strengths, not just bullet facts.
    6. **For reports** — highlight the most notable findings and give actionable recruiting insights.

    ## Response Format — HTML Only
    Format ALL responses as valid HTML. Do NOT use markdown syntax. Use only these elements:

    Paragraphs:   <p>text</p>
    Bold:         <strong>text</strong>
    Italic:       <em>text</em>
    Unordered:    <ul><li>item</li></ul>
    Ordered:      <ol><li>item</li></ol>
    Heading:      <h3>Section heading</h3>
    Subheading:   <h4>Subheading</h4>
    Divider:      <hr>
    Inline code:  <code>term</code>
    Code block:   <pre><code>multi-line code</code></pre>
    Blockquote:   <blockquote>notable insight</blockquote>
    Table — use for comparisons, stats breakdowns, and any structured data (prefer tables over lists for numbers):
      <table>
        <thead><tr><th>Column A</th><th>Column B</th></tr></thead>
        <tbody><tr><td>val1</td><td>val2</td></tr></tbody>
      </table>

    Output ONLY the HTML body content. No <html>, <head>, or <body> wrappers.

    ## Suggestions
    At the very end of every substantive response, append this exact HTML comment containing a valid JSON array of 2-3 follow-up question strings:
    <!-- suggestions: ["Follow-up question 1?", "Follow-up question 2?", "Follow-up question 3?"] -->

    Keep responses concise and actionable. Never invent data that is not from a tool result.
  PROMPT

  def initialize
    @ai = FuelixService.new
    @analytics = CandidateAnalyticsService.new
  end

  def process(user_message, history = [])
    messages = build_messages(history, user_message)

    accumulated_candidates = nil
    accumulated_stats = nil
    accumulated_exports = []

    MAX_ITERATIONS.times do
      response_text = @ai.chat_complete(messages, max_tokens: 4096, timeout: 120)

      tool_calls = parse_tool_calls(response_text)

      if tool_calls.empty?
        clean = strip_tool_calls(response_text)
        return {
          content:    clean,
          candidates: accumulated_candidates,
          stats:      accumulated_stats,
          exports:    accumulated_exports.presence
        }
      end

      tool_results_parts = []

      tool_calls.each do |tc|
        result = execute_tool(tc)
        accumulated_candidates = result[:candidates] if result[:candidates]
        accumulated_stats      = result[:stats]      if result[:stats]
        accumulated_exports << result[:export]       if result[:export]
        tool_results_parts << "=== Tool: #{tc['tool']} ===\n#{result[:text]}"
      end

      # Strip tool_call blocks from the partial assistant response
      partial_response = strip_tool_calls(response_text)
      messages << { role: "assistant", content: partial_response } if partial_response.present?

      tool_results_block = tool_results_parts.join("\n\n")
      messages << {
        role: "user",
        content: "Here are the tool results:\n\n#{tool_results_block}\n\nNow provide your final response to the user based on this data."
      }
    end

    {
      content:    "I had trouble processing that request. Please try rephrasing your question.",
      candidates: accumulated_candidates,
      stats:      accumulated_stats,
      exports:    accumulated_exports.presence
    }
  rescue StandardError => e
    Rails.logger.error("[ChatAgentService] process failed: #{e.message}\n#{e.backtrace.first(5).join("\n")}")
    {
      content:    "Sorry, I encountered an error while processing your request. Please try again.",
      candidates: nil,
      stats:      nil,
      exports:    nil
    }
  end

  private

  def build_messages(history, user_message)
    msgs = [{ role: "system", content: SYSTEM_PROMPT }]

    # Only include role+content from history (drop metadata like timestamps/candidates)
    history.last(20).each do |m|
      role = m.is_a?(Hash) ? (m["role"] || m[:role]).to_s : nil
      content = m.is_a?(Hash) ? (m["content"] || m[:content]).to_s : nil
      msgs << { role: role, content: content } if role.present? && content.present?
    end

    msgs << { role: "user", content: user_message }
    msgs
  end

  def parse_tool_calls(text)
    calls = []
    text.scan(/<tool_call>(.*?)<\/tool_call>/m) do |match|
      calls << JSON.parse(match[0].strip)
    rescue JSON::ParserError => e
      Rails.logger.warn("[ChatAgentService] Failed to parse tool_call JSON: #{e.message}")
    end
    calls
  end

  def strip_tool_calls(text)
    text.gsub(/<tool_call>.*?<\/tool_call>/m, "").strip
  end

  def execute_tool(tc)
    tool = tc["tool"].to_s
    params = tc["params"] || {}

    case tool
    when "database_summary"
      data = @analytics.database_summary
      { text: format_database_summary(data), stats: { type: "database_summary", data: data } }

    when "experience_report"
      data = @analytics.experience_report
      { text: format_experience_report(data), stats: { type: "experience_report", data: data } }

    when "role_distribution"
      data = @analytics.role_distribution
      { text: format_role_distribution(data), stats: { type: "role_distribution", data: data } }

    when "skill_report"
      skill = params["skill"].to_s.strip
      return { text: "Error: 'skill' parameter is required for skill_report." } if skill.blank?
      data = @analytics.skill_report(skill)
      { text: format_skill_report(data), stats: { type: "skill_report", data: data } }

    when "top_skills_by_category"
      limit = (params["limit"] || 10).to_i
      data = @analytics.top_skills_by_category(limit: limit)
      { text: format_top_skills(data), stats: { type: "top_skills_by_category", data: data } }

    when "search_candidates"
      query = params["query"].to_s.strip
      return { text: "Error: 'query' parameter is required for search_candidates." } if query.blank?
      limit = (params["limit"] || 8).to_i.clamp(1, 20)
      candidates = @analytics.search_candidates(query, limit: limit)
      { text: format_candidates_list(candidates), candidates: candidates }

    when "get_candidate"
      id = params["id"].to_i
      return { text: "Error: valid 'id' parameter required for get_candidate." } if id <= 0
      candidate = @analytics.get_candidate(id)
      return { text: "Candidate with ID #{id} not found." } if candidate.nil?
      { text: format_candidate_detail(candidate), candidates: [candidate] }

    when "export_csv"
      type  = params["type"].to_s.strip
      return { text: "Error: 'type' parameter is required for export_csv." } if type.blank?
      kw = params.transform_keys(&:to_sym).except(:type)
      result = @analytics.export_csv(type: type, **kw)
      { text: format_export(result), export: result }

    else
      { text: "Unknown tool '#{tool}'. Available tools: database_summary, experience_report, role_distribution, skill_report, top_skills_by_category, search_candidates, get_candidate, export_csv." }
    end
  rescue StandardError => e
    Rails.logger.error("[ChatAgentService] execute_tool '#{tc['tool']}' failed: #{e.message}")
    { text: "Tool '#{tc['tool']}' returned an error: #{e.message}" }
  end

  # ── Formatters (text passed to LLM for context) ────────────────────────────

  def format_database_summary(data)
    lines = ["CANDIDATE DATABASE SUMMARY", "Total candidates: #{data[:total_candidates]}", ""]

    if data[:experience_levels].any?
      lines << "EXPERIENCE LEVELS:"
      data[:experience_levels].each { |level, count| lines << "  #{level}: #{count}" }
      lines << ""
    end

    if data[:role_distribution].any?
      lines << "ROLE DISTRIBUTION (top roles):"
      data[:role_distribution].each { |role, count| lines << "  #{role}: #{count}" }
      lines << ""
    end

    if data[:skill_categories].any?
      lines << "SKILLS BY CATEGORY:"
      data[:skill_categories].each { |cat, count| lines << "  #{cat}: #{count} skill entries" }
      lines << ""
    end

    if data[:top_skills].any?
      lines << "TOP 15 SKILLS (by number of candidates):"
      data[:top_skills].each { |skill, count| lines << "  #{skill}: #{count}" }
    end

    lines.join("\n")
  end

  def format_experience_report(data)
    lines = ["EXPERIENCE LEVEL BREAKDOWN", "Average experience across database: #{data[:average_years]} years", ""]
    lines << "COUNTS BY LEVEL:"
    data[:levels].each { |level, count| lines << "  #{level}: #{count}" }
    lines.join("\n")
  end

  def format_role_distribution(data)
    lines = ["ROLE / FUNCTION DISTRIBUTION:"]
    data.each { |role, count| lines << "  #{role}: #{count} candidates" }
    lines.join("\n")
  end

  def format_skill_report(data)
    lines = [
      "SKILL REPORT: #{data[:skill_query]}",
      "Candidates with this skill: #{data[:total_candidates_with_skill]}",
      "Skill entries total: #{data[:total_skill_entries]}",
      "Avg experience: #{(data[:avg_months_experience] / 12.0).round(1)} years",
      "With certification: #{data[:with_certification]}",
      ""
    ]

    if data[:by_proficiency].any?
      lines << "BY PROFICIENCY:"
      data[:by_proficiency].each { |prof, count| lines << "  #{prof}: #{count}" }
      lines << ""
    end

    if data[:by_years_of_exp].any?
      lines << "BY YEARS OF EXP RANGE:"
      data[:by_years_of_exp].each { |yr, count| lines << "  #{yr}: #{count}" }
      lines << ""
    end

    if data[:sample_candidates].any?
      lines << "SAMPLE CANDIDATES:"
      data[:sample_candidates].each { |c| lines << "  ID #{c[:id]} – #{c[:name]} (#{c[:title]}) – #{c[:proficiency]}, #{c[:years]}" }
    end

    lines.join("\n")
  end

  def format_top_skills(data)
    lines = ["TOP SKILLS BY CATEGORY:"]
    data.each do |category, skills|
      lines << ""
      lines << "#{category}:"
      skills.each { |name, count| lines << "  #{name}: #{count} candidates" }
    end
    lines.join("\n")
  end

  def format_candidates_list(candidates)
    return "No candidates found matching that query." if candidates.empty?

    lines = ["SEARCH RESULTS (#{candidates.length} candidates):"]
    candidates.each_with_index do |c, i|
      skills_str = c[:skills].first(5).map { |s| s[:name] }.join(", ")
      lines << ""
      lines << "#{i + 1}. #{c[:full_name]} (ID: #{c[:id]})"
      lines << "   Title: #{c[:current_title] || 'N/A'}"
      lines << "   Location: #{c[:location].presence || 'N/A'}"
      lines << "   Experience: #{c[:total_experience_years]} years"
      lines << "   Top skills: #{skills_str}"
    end
    lines.join("\n")
  end

  def format_export(result)
    lines = [
      "CSV EXPORT READY",
      "Filename: #{result[:filename]}",
      "Expires in: #{result[:expires_in]}"
    ]
    lines << "Records: #{result[:record_count]}" if result[:record_count]
    lines << "(A download card will be shown to the user automatically. Do not include a download link in your HTML response.)"
    lines.join("\n")
  end

  def format_candidate_detail(c)
    lines = [
      "CANDIDATE PROFILE: #{c[:full_name]} (ID: #{c[:id]})",
      "Title: #{c[:current_title]}",
      "Location: #{c[:location]}",
      "Total experience: #{c[:total_experience_years]} years",
      ""
    ]

    lines << "ABOUT: #{c[:about_me]}" if c[:about_me].present?
    lines << ""

    if c[:skills].any?
      lines << "SKILLS:"
      c[:skills].first(10).each { |s| lines << "  #{s[:name]} – #{s[:proficiency]} (#{s[:years]}) [#{s[:category]}]" }
      lines << ""
    end

    if c[:work_experiences].any?
      lines << "WORK HISTORY:"
      c[:work_experiences].each do |w|
        lines << "  #{w[:title]} at #{w[:company]} (#{w[:duration]})"
        lines << "  #{w[:description]}" if w[:description].present?
      end
      lines << ""
    end

    if c[:certifications].any?
      lines << "CERTIFICATIONS:"
      c[:certifications].each { |cert| lines << "  #{cert[:name]} – #{cert[:org]}" }
    end

    lines.join("\n")
  end
end
