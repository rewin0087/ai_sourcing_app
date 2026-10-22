class CvMatchService
  # Weights used to derive the overall score from the AI's per-category scores.
  # Computing the total in Ruby keeps it consistent with the breakdown shown in the UI.
  CATEGORY_WEIGHTS = {
    "skills" => 0.40,
    "experience" => 0.30,
    "responsibilities" => 0.20,
    "education" => 0.10
  }.freeze

  MATCH_PROMPT = <<~PROMPT
    You are a senior technical recruiter and talent assessor. Compare the CANDIDATE CV against the JOB DESCRIPTION
    and reason carefully about how well the candidate fits the role. Be evidence-based: only credit a skill or
    experience when the CV supports it, and quote or paraphrase the CV as evidence. Be fair but rigorous — do not inflate scores.

    Return ONLY a single minified valid JSON object. NO markdown fences, no prose. First character must be "{" and last must be "}".

    Schema:
    {
      "job": { "title": "", "experience_level": "entry|mid|senior|lead", "required_years": 0 },
      "candidate": { "name": "", "current_title": "", "total_experience_years": 0 },
      "summary": "2-3 sentence executive summary of the fit",
      "recommendation": "strong_yes|yes|maybe|no",
      "recommendation_reason": "One sentence explaining the hiring recommendation",
      "category_scores": {
        "skills": { "score": 0, "rationale": "" },
        "experience": { "score": 0, "rationale": "" },
        "responsibilities": { "score": 0, "rationale": "" },
        "education": { "score": 0, "rationale": "" }
      },
      "skills_analysis": [
        {
          "skill": "",
          "importance": "required|preferred",
          "status": "matched|partial|missing",
          "evidence": "Where/how the CV demonstrates it, or why it is partial/missing"
        }
      ],
      "experience_analysis": {
        "assessment": "How the candidate's years, seniority and domain compare to the role",
        "relevant_roles": [
          { "title": "", "company": "", "duration": "", "relevance": "high|medium|low", "note": "" }
        ]
      },
      "strengths": [ { "title": "", "detail": "" } ],
      "gaps": [ { "title": "", "detail": "", "severity": "high|medium|low" } ],
      "improvements": [ { "title": "", "detail": "", "impact": "high|medium|low" } ],
      "interview_questions": [ "" ],
      "interview_prep": {
        "role_type": "technical|non_technical",
        "focus_areas": [ { "topic": "", "reason": "", "priority": "high|medium|low" } ],
        "coding_challenges": [
          {
            "title": "",
            "difficulty": "easy|medium|hard",
            "problem": "Clear problem statement with example input/output",
            "skills_tested": [ "" ],
            "hints": [ "" ],
            "approach": "Outline of an optimal solution and its time/space complexity"
          }
        ],
        "algorithms": [ { "name": "", "relevance": "", "complexity": "" } ],
        "theory_questions": [ { "question": "", "topic": "", "key_points": [ "" ] } ],
        "applied_scenarios": [
          {
            "scenario": "Application-level / system design / problem-solving scenario tied to the role",
            "type": "system_design|debugging|architecture|problem_solving|case_study",
            "what_interviewers_look_for": [ "" ]
          }
        ]
      }
    }

    Rules:
    - All scores are integers 0-100.
      skills = coverage of required (weighted heavier) and preferred skills.
      experience = years, seniority and domain relevance vs what the role needs.
      responsibilities = how closely past duties/achievements mirror the role's responsibilities.
      education = degrees and certifications vs requirements (score 80+ if the JD has no education requirement and nothing is missing).
    - skills_analysis: list EVERY skill/technology/qualification the JD asks for (required and preferred), max 25 items.
      "partial" = related or weaker evidence (e.g. similar tool, fewer years, mentioned without depth).
    - strengths: 3-6 items, the strongest reasons this candidate fits.
    - gaps: 0-6 items, genuine shortfalls vs the JD. Empty array if none.
    - improvements: 3-6 concrete, actionable items the candidate could do to become a stronger or perfect match
      (skills to learn, experience to highlight, CV wording to add, certifications). If already a near-perfect match,
      focus on how to present the CV even better.
    - interview_questions: 3-5 targeted questions to validate gaps or claims.
    - recommendation: strong_yes (exceptional fit), yes (good fit), maybe (notable gaps), no (poor fit).
    - interview_prep: help the CANDIDATE prepare for this role's interview, based on the JD's tech stack and seniority,
      with extra emphasis on the gaps found above.
      focus_areas: 3-5 topics to study, highest priority first.
      coding_challenges: 2-4 realistic challenges in the style this role is likely to ask, using the JD's languages/domain,
        ranging in difficulty to match seniority. hints: 2-3 progressive hints that do not give away the answer.
      algorithms: 3-6 algorithms / data structures / patterns worth revising, and why they are relevant to this role.
      theory_questions: 4-6 conceptual questions on the JD's core technologies, with 2-4 key points a strong answer covers.
      applied_scenarios: 2-3 application-level thinking exercises (system design for senior roles, debugging or
        architecture trade-offs, or case-style problem solving) grounded in the role's responsibilities.
      If the role is NOT technical, set role_type "non_technical" and return empty arrays for coding_challenges and
      algorithms; use theory_questions and applied_scenarios for domain knowledge and case questions instead.

    JOB DESCRIPTION:
    %{jd_text}

    CANDIDATE CV:
    %{cv_text}

    Return ONLY the JSON object.
  PROMPT

  def initialize
    @ai = FuelixService.new
  end

  def match(jd_text:, cv_text:)
    prompt = MATCH_PROMPT % { jd_text: jd_text.truncate(15000), cv_text: cv_text.truncate(25000) }
    extracted = @ai.extract_json(prompt, max_tokens: 16384, timeout: 240)

    category_scores = normalize_category_scores(extracted["category_scores"])
    overall = compute_overall(category_scores)

    {
      success: true,
      overall_score: overall,
      match_level: match_level(overall),
      summary: extracted["summary"],
      recommendation: extracted["recommendation"],
      recommendation_reason: extracted["recommendation_reason"],
      job: extracted["job"] || {},
      candidate: extracted["candidate"] || {},
      category_scores: category_scores,
      skills_analysis: Array(extracted["skills_analysis"]),
      experience_analysis: extracted["experience_analysis"] || {},
      strengths: Array(extracted["strengths"]),
      gaps: Array(extracted["gaps"]),
      improvements: Array(extracted["improvements"]),
      interview_questions: Array(extracted["interview_questions"]),
      interview_prep: normalize_interview_prep(extracted["interview_prep"])
    }
  rescue JSON::ParserError => e
    { success: false, error: "AI returned invalid JSON: #{e.message}" }
  rescue StandardError => e
    { success: false, error: e.message }
  end

  private

  def normalize_category_scores(raw)
    raw = {} unless raw.is_a?(Hash)
    CATEGORY_WEIGHTS.keys.index_with do |key|
      entry = raw[key].is_a?(Hash) ? raw[key] : {}
      {
        "score" => entry["score"].to_i.clamp(0, 100),
        "rationale" => entry["rationale"].to_s,
        "weight" => (CATEGORY_WEIGHTS[key] * 100).round
      }
    end
  end

  def normalize_interview_prep(raw)
    raw = {} unless raw.is_a?(Hash)
    {
      "role_type" => raw["role_type"] == "non_technical" ? "non_technical" : "technical",
      "focus_areas" => Array(raw["focus_areas"]),
      "coding_challenges" => Array(raw["coding_challenges"]),
      "algorithms" => Array(raw["algorithms"]),
      "theory_questions" => Array(raw["theory_questions"]),
      "applied_scenarios" => Array(raw["applied_scenarios"])
    }
  end

  def compute_overall(category_scores)
    category_scores.sum { |key, entry| entry["score"] * CATEGORY_WEIGHTS[key] }.round
  end

  def match_level(score)
    case score
    when 85.. then "excellent"
    when 70...85 then "strong"
    when 50...70 then "moderate"
    else "weak"
    end
  end
end
