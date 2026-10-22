class CandidateMatchingService
  TOP_K = 20
  RETRIEVAL_DEPTH = 50
  RRF_K = 60
  RAG_CONTEXT_CANDIDATES = 5

  RAG_PROMPT = <<~PROMPT
    You are a technical recruiter AI. Analyze these candidates against the job requirements and provide reasoning for each match.

    JOB REQUIREMENTS:
    %{job_summary}

    TOP CANDIDATE PROFILES:
    %{candidates_context}

    For each candidate, evaluate:
    1. Skill match percentage (required skills they have vs total required)
    2. Experience relevance (how relevant their work history is)
    3. Years of experience alignment
    4. Overall fit score (0-100)
    5. Key strengths for this role
    6. Gaps or concerns

    Return ONLY a JSON array (no markdown):
    [
      {
        "candidate_id": 0,
        "overall_score": 85,
        "skill_match_score": 90,
        "experience_match_score": 80,
        "reasoning": "Strong match because...",
        "matched_skills": ["skill1", "skill2"],
        "missing_skills": ["skill3"]
      }
    ]
  PROMPT

  # Full-text document per candidate. Skills carry the most weight, then titles,
  # then experience/project descriptions, then the free-text bio.
  KEYWORD_SQL = <<~SQL
    WITH docs AS (
      SELECT c.id,
        setweight(to_tsvector('simple', coalesce((SELECT string_agg(s.name, ' ') FROM candidate_skills s WHERE s.candidate_id = c.id), '')), 'A') ||
        setweight(to_tsvector('simple', concat_ws(' ', c.current_title,
          (SELECT string_agg(w.job_title, ' ') FROM work_experiences w WHERE w.candidate_id = c.id))), 'B') ||
        setweight(to_tsvector('simple', concat_ws(' ',
          (SELECT string_agg(w.description, ' ') FROM work_experiences w WHERE w.candidate_id = c.id),
          (SELECT string_agg(concat_ws(' ', p.skills_used, p.description), ' ')
             FROM work_projects p JOIN work_experiences w ON w.id = p.work_experience_id
            WHERE w.candidate_id = c.id))), 'C') ||
        setweight(to_tsvector('simple', coalesce(c.about_me, '')), 'D') AS doc
      FROM candidates c
    )
    SELECT docs.id FROM docs, (SELECT %{query}) AS q(query)
    WHERE docs.doc @@ q.query
    ORDER BY ts_rank_cd(docs.doc, q.query) DESC, docs.id
    LIMIT %{limit}
  SQL

  include VectorSimilarity

  def initialize
    @ai = FuelixService.new
  end

  def search(job_description, limit: 10)
    candidates = Candidate.includes(:candidate_skills, :work_experiences).to_a
    return [] if candidates.empty?

    # Step 1: Independent retrievers, each producing its own ranked list of candidate ids
    similarities = semantic_scores(job_description, candidates)
    skill_matches = skill_scores(job_description, candidates)
    rankings = {
      semantic: rank_ids(similarities),
      keyword: keyword_ranking(job_description),
      skills: rank_ids(skill_matches.transform_values { |m| m[:score] })
    }

    # Step 2: Reciprocal Rank Fusion — combines ranks rather than raw scores,
    # so retrievers with different score scales contribute fairly
    fused = reciprocal_rank_fusion(rankings).first(TOP_K)
    return [] if fused.empty?

    by_id = candidates.index_by(&:id)
    scored = fused.map do |id, rrf_score|
      build_result(by_id[id], rrf_score, rankings, similarities[id], skill_matches[id], semantic: similarities.any?)
    end

    # Step 3: RAG - feed top fused candidates to AI for deep reasoning
    ai_insights = generate_ai_insights(job_description, scored.first(RAG_CONTEXT_CANDIDATES))

    # Step 4: Merge AI insights, fuse the AI ranking in as a further list, and re-rank
    final_results = merge_insights(scored, ai_insights)

    # Step 5: Persist matches
    persist_matches(job_description, final_results)

    final_results.first(limit)
  end

  private

  # candidate_id => cosine similarity, for candidates with a usable embedding
  def semantic_scores(job_description, candidates)
    job_vec = job_description.embedding
    return {} unless job_vec.is_a?(Array) && job_vec.any?

    candidates.each_with_object({}) do |c, h|
      vec = c.profile_embedding
      next unless vec.is_a?(Array) && vec.length == job_vec.length

      h[c.id] = cosine_similarity(job_vec, vec).round(4)
    end
  rescue StandardError => e
    Rails.logger.error("Vector search failed: #{e.message}")
    {}
  end

  def keyword_ranking(job_description)
    terms = (job_description.required_skills_list + skill_names(job_description.preferred_skills) + [job_description.title])
      .compact.map(&:strip).reject(&:blank?).uniq(&:downcase)
    return [] if terms.empty?

    query = Array.new(terms.size, "plainto_tsquery('simple', ?)").join(" || ")
    sql = format(KEYWORD_SQL, query: ActiveRecord::Base.sanitize_sql_array([query, *terms]), limit: RETRIEVAL_DEPTH)
    ActiveRecord::Base.connection.select_values(sql).map(&:to_i)
  rescue StandardError => e
    Rails.logger.error("Keyword search failed: #{e.message}")
    []
  end

  # candidate_id => { score:, matched:, missing: } based on structured skill overlap
  def skill_scores(job_description, candidates)
    required = normalized_skill_map(job_description.required_skills)
    preferred = normalized_skill_map(job_description.preferred_skills)

    candidates.to_h do |candidate|
      have = candidate.candidate_skills.map { |s| normalize_skill(s.name) }.to_set
      matched_required = required.keys.select { |k| have.include?(k) }
      matched_preferred = preferred.keys.select { |k| have.include?(k) }

      score = if required.empty?
        preferred.empty? ? 0.0 : matched_preferred.size.to_f / preferred.size
      else
        (matched_required.size.to_f / required.size * 0.8) +
          (preferred.empty? ? 0 : matched_preferred.size.to_f / preferred.size * 0.2)
      end

      [candidate.id, {
        score: score.round(4),
        matched: matched_required.map { |k| required[k] },
        missing: (required.keys - matched_required).map { |k| required[k] }
      }]
    end
  end

  # Ids ordered by descending score, ignoring zero scores, capped at RETRIEVAL_DEPTH
  def rank_ids(scores)
    scores.select { |_, s| s.positive? }.sort_by { |id, s| [-s, id] }.first(RETRIEVAL_DEPTH).map(&:first)
  end

  def reciprocal_rank_fusion(rankings)
    scores = Hash.new(0.0)
    rankings.each_value do |ids|
      ids.each_with_index { |id, idx| scores[id] += 1.0 / (RRF_K + idx + 1) }
    end
    scores.sort_by { |id, s| [-s, id] }
  end

  def build_result(candidate, rrf_score, rankings, similarity, skill_match, semantic:)
    exp_score = experience_score(candidate)
    skill_score = skill_match[:score]

    # Absolute fit estimate for display; drop the similarity term when no embeddings are available
    overall = if semantic
      (similarity.to_f * 0.4) + (skill_score * 0.4) + (exp_score * 0.2)
    else
      (skill_score * 0.67) + (exp_score * 0.33)
    end

    {
      candidate: candidate,
      similarity_score: similarity.to_f,
      skill_match_score: skill_score,
      experience_match_score: exp_score,
      overall_score: overall.round(4),
      rrf_score: rrf_score,
      retrieval_ranks: rankings.transform_values { |ids| (idx = ids.index(candidate.id)) && idx + 1 },
      matched_skills: skill_match[:matched],
      missing_skills: skill_match[:missing]
    }
  end

  def experience_score(candidate)
    today = Date.today
    exp_months = candidate.work_experiences.sum do |w|
      start = w.start_date || today
      finish = w.end_date || today
      [(finish.year * 12 + finish.month) - (start.year * 12 + start.month), 0].max
    end

    case exp_months / 12.0
    when 0...2 then 0.3
    when 2...5 then 0.6
    when 5...10 then 0.85
    else 1.0
    end
  end

  def generate_ai_insights(job_description, top_candidates)
    return {} if top_candidates.empty?

    job_summary = [
      "Title: #{job_description.title}",
      "Summary: #{job_description.summary}",
      "Required Skills: #{job_description.required_skills_list.join(', ')}",
      "Qualifications: #{job_description.qualifications&.truncate(500)}"
    ].join("\n")

    candidates_context = top_candidates.map do |item|
      c = item[:candidate]
      skills = c.candidate_skills.map { |s| "#{s.name}(#{s.proficiency})" }.join(", ")
      experience = c.work_experiences.first(3).map { |w| "#{w.job_title} at #{w.company_name}" }.join(", ")
      "Candidate #{c.id}: #{c.current_title || 'N/A'} | Skills: #{skills} | Experience: #{experience}"
    end.join("\n")

    prompt = RAG_PROMPT % { job_summary: job_summary, candidates_context: candidates_context }

    raw = @ai.complete(prompt, temperature: 0, max_tokens: 2048, timeout: 90)
    cleaned = raw.gsub(/```json\s*/i, "").gsub(/```\s*$/, "").strip
    match = cleaned.match(/\[.*\]/m)
    return {} unless match

    results = JSON.parse(match[0])
    results.each_with_object({}) { |r, h| h[r["candidate_id"].to_i] = r }
  rescue StandardError => e
    Rails.logger.error("RAG insights failed: #{e.message}")
    {}
  end

  def merge_insights(scored, ai_insights)
    # The AI's ordering of the candidates it reviewed is fused in as one more ranked list
    ai_ranked_ids = scored.map { |item| item[:candidate].id }
      .select { |id| ai_insights[id] }
      .sort_by { |id| -ai_insights[id]["overall_score"].to_f }

    scored.each do |item|
      candidate = item[:candidate]
      insight = ai_insights[candidate.id] || {}
      ai_rank = ai_ranked_ids.index(candidate.id)
      item[:retrieval_ranks] = item[:retrieval_ranks].merge(ai: ai_rank && ai_rank + 1)
      next if insight.empty?

      item[:rrf_score] += 1.0 / (RRF_K + ai_rank + 1)
      item[:ai_reasoning] = insight["reasoning"]
      item[:overall_score] = (insight["overall_score"].to_f / 100).clamp(0.0, 1.0).round(4)
      item[:matched_skills] = insight["matched_skills"] || item[:matched_skills]
      item[:missing_skills] = insight["missing_skills"] || item[:missing_skills]
    end

    scored.sort_by { |item| [-item[:rrf_score], -item[:overall_score]] }.each_with_index do |item, idx|
      item[:rrf_score] = item[:rrf_score].round(6)
      item[:rank] = idx + 1
    end
  end

  def persist_matches(job_description, results)
    results.each do |item|
      CandidateJobMatch.upsert(
        {
          candidate_id: item[:candidate].id,
          job_description_id: job_description.id,
          similarity_score: item[:similarity_score],
          skill_match_score: item[:skill_match_score],
          experience_match_score: item[:experience_match_score],
          overall_score: item[:overall_score],
          rank: item[:rank],
          ai_reasoning: item[:ai_reasoning],
          matched_skills: item[:matched_skills],
          missing_skills: item[:missing_skills],
          created_at: Time.current,
          updated_at: Time.current
        },
        unique_by: [:candidate_id, :job_description_id],
        update_only: [:similarity_score, :skill_match_score, :experience_match_score, :overall_score, :rank, :ai_reasoning, :matched_skills, :missing_skills, :updated_at]
      )
    end
  rescue StandardError => e
    Rails.logger.error("Failed to persist matches: #{e.message}")
  end

  def skill_names(skills)
    Array(skills).map { |s| s["name"] || s[:name] }.compact
  end

  # normalized name => display name
  def normalized_skill_map(skills)
    skill_names(skills).each_with_object({}) do |name, h|
      key = normalize_skill(name)
      h[key] ||= name if key.present?
    end
  end

  # "Node.js" / "NodeJS" / "node js" => "nodejs"; keeps + and # so C++ and C# stay distinct
  def normalize_skill(name)
    name.to_s.downcase.gsub(/[^a-z0-9+#]/, "")
  end
end
