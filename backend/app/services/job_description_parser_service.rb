require "pdf/reader"

class JobDescriptionParserService
  EXTRACTION_PROMPT = <<~PROMPT
    You are a job description data extraction engine. Your entire response MUST be a single minified valid JSON object and nothing else.
    NO markdown fences, no prose. First character must be "{" and last must be "}".

    Extract structured data from this job description:

    {
      "title": "",
      "company_name": "",
      "location": "",
      "employment_type": "Full-time|Part-time|Contract|Remote",
      "experience_level": "entry|mid|senior|lead",
      "summary": "",
      "responsibilities": "",
      "qualifications": "",
      "about_company": "",
      "salary_range": null,
      "required_skills": [
        {
          "name": "",
          "proficiency": "Beginner|Intermediate|Advanced",
          "years_required": 0,
          "required": true
        }
      ],
      "preferred_skills": [
        {
          "name": "",
          "proficiency": "Beginner|Intermediate|Advanced",
          "years_required": 0,
          "required": false
        }
      ]
    }

    Rules:
    - Extract ALL technical skills mentioned (programming languages, frameworks, tools, platforms)
    - required_skills: explicitly required or "must have"
    - preferred_skills: "nice to have", "plus", "bonus" skills
    - Combine all responsibility bullets into responsibilities as a paragraph
    - Combine all qualification bullets into qualifications as a paragraph
    - experience_level: entry (<2yr), mid (2-5yr), senior (5-10yr), lead (10yr+)
    - If years not stated, estimate from context
    - salary_range: extract if mentioned (e.g. "$80k-$100k", null if not mentioned)

    JOB DESCRIPTION TEXT:
    %{jd_text}

    Return ONLY the JSON object.
  PROMPT

  def initialize
    @ai = FuelixService.new
    @embedding = EmbeddingService.new
  end

  def parse(job_description)
    job_description.update!(status: "processing")

    text = job_description.raw_text
    prompt = EXTRACTION_PROMPT % { jd_text: text.truncate(20000) }
    extracted = @ai.extract_json(prompt, max_tokens: 4096, timeout: 120)

    job_description.update!(
      title: extracted["title"],
      company_name: extracted["company_name"],
      location: extracted["location"],
      employment_type: extracted["employment_type"],
      experience_level: extracted["experience_level"],
      summary: extracted["summary"],
      responsibilities: extracted["responsibilities"],
      qualifications: extracted["qualifications"],
      about_company: extracted["about_company"],
      salary_range: extracted["salary_range"],
      required_skills: extracted["required_skills"] || [],
      preferred_skills: extracted["preferred_skills"] || [],
      parsed_data: extracted,
      status: "completed"
    )

    @embedding.generate_for_job(job_description)

    { success: true, job_description: job_description }
  rescue JSON::ParserError => e
    job_description.update!(status: "failed")
    { success: false, error: "AI returned invalid JSON: #{e.message}" }
  rescue StandardError => e
    job_description.update!(status: "failed")
    { success: false, error: e.message }
  end

  def self.extract_text_from_file(path)
    ext = File.extname(path).downcase
    case ext
    when ".pdf"
      reader = PDF::Reader.new(path)
      reader.pages.map(&:text).join("\n")
    when ".txt", ".md"
      File.read(path)
    else
      raise ArgumentError, "Unsupported file type: #{ext}"
    end
  end
end
