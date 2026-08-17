class JobDescriptionRefinerService
  REFINEMENT_PROMPT = <<~PROMPT
    You are a professional job description writer and HR consultant. Your task is to transform a simple narrative job description into a comprehensive, well-structured job description that will attract the right candidates.

    Return ONLY a single minified valid JSON object. NO markdown fences, no prose. First character must be "{" and last must be "}".

    Schema:
    {
      "title": "Clear, specific job title",
      "experience_level": "entry|mid|senior|lead",
      "employment_type": "Full-time|Part-time|Contract|Remote",
      "summary": "Compelling 2-3 sentence job summary describing the role, team, and impact",
      "responsibilities": "Detailed paragraph covering all key responsibilities and day-to-day activities. Expand bullet points into complete sentences.",
      "qualifications": "Detailed paragraph covering must-have qualifications, educational background, years of experience, and core competencies required.",
      "about_company": "Generic professional company description (omit if not mentioned in narrative)",
      "required_skills": [
        {
          "name": "Skill name",
          "proficiency": "Beginner|Intermediate|Advanced",
          "years_required": 0
        }
      ],
      "preferred_skills": [
        {
          "name": "Skill name",
          "proficiency": "Beginner|Intermediate|Advanced",
          "years_required": 0
        }
      ],
      "formatted_text": "Full formatted plain-text job description combining all sections with section headers. This will be used directly for candidate matching."
    }

    Rules:
    - Infer reasonable requirements from context (e.g. 'senior dev' implies 5+ years experience)
    - Extract ALL technical skills mentioned and any implied skills
    - required_skills: skills explicitly mentioned or clearly required
    - preferred_skills: implied nice-to-have skills based on the role context
    - For formatted_text: format as a readable job description with clear sections (Job Summary, Key Responsibilities, Required Qualifications, Technical Skills, Preferred Qualifications). This field is critical — make it comprehensive.
    - Expand terse narratives into professional, detailed language while preserving the original intent

    NARRATIVE JOB DESCRIPTION:
    %{narrative}

    Return ONLY the JSON object.
  PROMPT

  def initialize
    @ai = FuelixService.new
  end

  def refine(narrative_text)
    prompt = REFINEMENT_PROMPT % { narrative: narrative_text.truncate(10000) }
    extracted = @ai.extract_json(prompt, max_tokens: 4096, timeout: 120)

    {
      success: true,
      title: extracted["title"],
      experience_level: extracted["experience_level"],
      employment_type: extracted["employment_type"],
      summary: extracted["summary"],
      responsibilities: extracted["responsibilities"],
      qualifications: extracted["qualifications"],
      about_company: extracted["about_company"],
      required_skills: extracted["required_skills"] || [],
      preferred_skills: extracted["preferred_skills"] || [],
      formatted_text: extracted["formatted_text"]
    }
  rescue JSON::ParserError => e
    { success: false, error: "AI returned invalid JSON: #{e.message}" }
  rescue StandardError => e
    { success: false, error: e.message }
  end
end
