class CandidateMatchingService
  TOP_K = 20
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

  def initialize
    @ai = FuelixService.new
  end

  def search(job_description, limit: 10)
    return [] unless job_description.embedding.present?

    # Step 1: Vector similarity search against candidate profile embeddings
    similar_candidates = find_similar_candidates(job_description, limit: TOP_K)
    return [] if similar_candidates.empty?

    # Step 2: Skill-based filtering and scoring
    scored = score_by_skills(similar_candidates, job_description)

    # Step 3: RAG - feed top candidates to AI for deep reasoning
    top_for_rag = scored.first(RAG_CONTEXT_CANDIDATES)
    ai_insights = generate_ai_insights(job_description, top_for_rag)

    # Step 4: Merge AI insights with scores
    final_results = merge_insights(scored, ai_insights)

    # Step 5: Persist matches
    persist_matches(job_description, final_results)

    final_results.first(limit)
  end

  private

  def find_similar_candidates(job_description, limit:)
    embedding = job_description.embedding
    return [] unless embedding

    Candidate
      .where.not(profile_embedding: nil)
      .nearest_neighbors(:profile_embedding, embedding, distance: "cosine")
      .limit(limit)
      .map do |candidate|
        {
          candidate: candidate,
          similarity_score: candidate.neighbor_distance.present? ? (1 - candidate.neighbor_distance.to_f).round(4) : 0.0
        }
      end
  rescue StandardError => e
    Rails.logger.error("Vector search failed: #{e.message}")
    []
  end

  def score_by_skills(candidates_with_scores, job_description)
    required = (job_description.required_skills || []).map { |s| (s["name"] || s[:name]).to_s.downcase }.to_set
    preferred = (job_description.preferred_skills || []).map { |s| (s["name"] || s[:name]).to_s.downcase }.to_set

    candidates_with_scores.map do |item|
      candidate = item[:candidate]
      candidate_skill_names = candidate.candidate_skills.map { |s| s.name.downcase }.to_set

      matched_required = required & candidate_skill_names
      matched_preferred = preferred & candidate_skill_names
      missing_required = required - candidate_skill_names

      skill_score = if required.empty?
        0.5
      else
        (matched_required.size.to_f / required.size * 0.8) +
          (preferred.empty? ? 0 : matched_preferred.size.to_f / preferred.size * 0.2)
      end

      # Experience score: prefer candidates with relevant experience years
      exp_months = candidate.work_experiences.sum { |w|
        if w.end_date
          ((w.end_date.year * 12 + w.end_date.month) - (w.start_date.year * 12 + w.start_date.month)).to_i
        else
          today = Date.today
          ((today.year * 12 + today.month) - ((w.start_date&.year || today.year) * 12 + (w.start_date&.month || today.month))).to_i
        end
      }
      exp_years = [exp_months / 12.0, 0].max
      exp_score = case exp_years
      when 0..2 then 0.3
      when 2..5 then 0.6
      when 5..10 then 0.85
      else 1.0
      end

      overall = (item[:similarity_score] * 0.4 + skill_score * 0.4 + exp_score * 0.2).round(4)

      item.merge(
        skill_match_score: skill_score.round(4),
        experience_match_score: exp_score.round(4),
        overall_score: overall,
        matched_skills: matched_required.to_a,
        missing_skills: missing_required.to_a
      )
    end.sort_by { |i| -i[:overall_score] }
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
    scored.each_with_index.map do |item, idx|
      candidate = item[:candidate]
      insight = ai_insights[candidate.id] || {}

      if insight.any?
        item[:ai_reasoning] = insight["reasoning"]
        item[:overall_score] = [(insight["overall_score"].to_f / 100).round(4), item[:overall_score]].max
        item[:matched_skills] = insight["matched_skills"] || item[:matched_skills]
        item[:missing_skills] = insight["missing_skills"] || item[:missing_skills]
      end

      item[:rank] = idx + 1
      item
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
          matched_skills: item[:matched_skills].to_json,
          missing_skills: item[:missing_skills].to_json,
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
end
