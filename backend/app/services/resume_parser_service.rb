require "open3"

class ResumeParserService
  EXTRACTION_PROMPT = <<~PROMPT
    You are a resume data extraction engine. Your entire response MUST be a single minified valid JSON object and nothing else.
    NO markdown fences, no prose, no extra keys. The very first character must be "{" and the very last must be "}".

    Extract the following structured data from the resume text:

    {
      "personal": {
        "first_name": "",
        "last_name": "",
        "middle_name": null,
        "email": "",
        "phone": "",
        "address": "",
        "city": "",
        "state": "",
        "country": "",
        "postal_code": null,
        "current_title": "",
        "about_me": null,
        "linkedin_url": null,
        "github_url": null,
        "portfolio_url": null
      },
      "skills": [
        {
          "name": "",
          "category": "Backend|Frontend|Languages|Databases|Cloud & DevOps|Testing|Source Control|AI & LLM Tools|Other",
          "proficiency": "Beginner|Intermediate|Advanced",
          "years_of_exp": "Less than 5 years|5 - 10 years|More than 10 years",
          "years_of_exp_in_months": 0,
          "skill_type": "Primary|Secondary|Tertiary",
          "year_last_used": null,
          "certification": "Yes|No",
          "delivered_projects": "Less than 5|5 - 10|More than 10"
        }
      ],
      "work_experiences": [
        {
          "company_name": "",
          "job_title": "",
          "work_status": 0,
          "employment_type": 1,
          "location": null,
          "location_type": 1,
          "description": "",
          "start_date": "YYYY-MM-DD",
          "end_date": null,
          "projects": [
            {
              "project_name": "",
              "project_status": 1,
              "description": "",
              "skills_used": "",
              "start_date": null,
              "end_date": null
            }
          ]
        }
      ],
      "educations": [
        {
          "school_name": "",
          "degree_obtained": "",
          "field_of_study": "",
          "start_date": null,
          "end_date": null,
          "still_studying": false,
          "description": null
        }
      ],
      "certifications": [
        {
          "certificate_name": "",
          "issuing_org": null,
          "issue_date": null,
          "expiry_date": null,
          "skills_covered": ""
        }
      ]
    }

    Rules:
    - work_status: 1=current (Present/Now/Ongoing), 0=past
    - employment_type: 1=Full-time, 2=Part-time, 3=Contract
    - location_type: 1=On-site, 2=Remote, 3=Hybrid
    - All dates in "YYYY-MM-DD" format or null
    - Extract implicit skills from job bullets
    - year_last_used is null ONLY when skill is actively used in current job

    RESUME TEXT:
    %{resume_text}

    Return ONLY the JSON object.
  PROMPT

  def initialize
    @ai = FuelixService.new
    @embedding = EmbeddingService.new
  end

  def parse(candidate, file_path: nil, text: nil)
    resume_text = text || extract_text_from_file(file_path)
    raise ArgumentError, "No resume text provided" if resume_text.blank?

    prompt = EXTRACTION_PROMPT % { resume_text: resume_text.truncate(30000) }
    extracted = @ai.extract_json(prompt, max_tokens: 16384, timeout: 240)

    ActiveRecord::Base.transaction do
      update_candidate_profile(candidate, extracted["personal"])
      sync_skills(candidate, extracted["skills"] || [])
      sync_work_experiences(candidate, extracted["work_experiences"] || [])
      sync_educations(candidate, extracted["educations"] || [])
      sync_certifications(candidate, extracted["certifications"] || [])
      generate_candidate_embeddings(candidate)
    end

    { success: true, extracted: extracted }
  rescue JSON::ParserError => e
    { success: false, error: "AI returned invalid JSON: #{e.message}" }
  rescue StandardError => e
    { success: false, error: e.message }
  end

  private

  def extract_text_from_file(path)
    return nil unless path

    ext = File.extname(path).downcase
    case ext
    when ".pdf"
      text, status = Open3.capture2("pdftotext", path, "-")
      raise "pdftotext failed (exit #{status.exitstatus})" unless status.success?
      text.encode("UTF-8", invalid: :replace, undef: :replace, replace: " ")
    when ".txt", ".md"
      File.read(path, encoding: "binary")
          .encode("UTF-8", "binary", invalid: :replace, undef: :replace, replace: " ")
    else
      raise ArgumentError, "Unsupported file type: #{ext}"
    end
  end

  def update_candidate_profile(candidate, personal)
    return unless personal

    candidate.update!(
      first_name: personal["first_name"],
      last_name: personal["last_name"],
      middle_name: personal["middle_name"],
      email: personal["email"],
      phone: personal["phone"],
      address: personal["address"],
      city: personal["city"],
      state: personal["state"],
      country: personal["country"],
      postal_code: personal["postal_code"],
      current_title: personal["current_title"],
      about_me: personal["about_me"],
      linkedin_url: personal["linkedin_url"],
      github_url: personal["github_url"],
      portfolio_url: personal["portfolio_url"]
    )
  end

  def sync_skills(candidate, skills)
    existing = candidate.candidate_skills.index_by { |s| s.name.downcase }
    skills.each do |skill_data|
      name = skill_data["name"]
      next if name.blank?

      attrs = {
        name: name,
        category: skill_data["category"],
        proficiency: skill_data["proficiency"],
        years_of_exp: skill_data["years_of_exp"],
        years_of_exp_in_months: skill_data["years_of_exp_in_months"].to_i,
        skill_type: skill_data["skill_type"],
        year_last_used: skill_data["year_last_used"],
        certification: skill_data["certification"] || "No",
        delivered_projects: skill_data["delivered_projects"]
      }

      skill = existing[name.downcase] || candidate.candidate_skills.new
      skill.assign_attributes(attrs)
      skill.save!
    end
  end

  def sync_work_experiences(candidate, experiences)
    candidate.work_experiences.destroy_all
    experiences.each do |exp_data|
      exp = candidate.work_experiences.create!(
        company_name: exp_data["company_name"],
        job_title: exp_data["job_title"],
        work_status: exp_data["work_status"].to_i,
        employment_type: exp_data["employment_type"]&.to_i || 1,
        location: exp_data["location"],
        location_type: exp_data["location_type"]&.to_i || 1,
        description: exp_data["description"],
        start_date: parse_date(exp_data["start_date"]),
        end_date: parse_date(exp_data["end_date"])
      )

      (exp_data["projects"] || []).each do |proj|
        exp.work_projects.create!(
          project_name: proj["project_name"],
          project_status: proj["project_status"]&.to_i || 1,
          description: proj["description"],
          skills_used: proj["skills_used"],
          start_date: parse_date(proj["start_date"]),
          end_date: parse_date(proj["end_date"])
        )
      end
    end
  end

  def sync_educations(candidate, educations)
    candidate.educations.destroy_all
    educations.each do |edu|
      candidate.educations.create!(
        school_name: edu["school_name"],
        degree_obtained: edu["degree_obtained"],
        field_of_study: edu["field_of_study"],
        start_date: parse_date(edu["start_date"]),
        end_date: parse_date(edu["end_date"]),
        still_studying: edu["still_studying"] || false,
        description: edu["description"]
      )
    end
  end

  def sync_certifications(candidate, certs)
    candidate.certifications.destroy_all
    certs.each do |cert|
      candidate.certifications.create!(
        certificate_name: cert["certificate_name"],
        issuing_org: cert["issuing_org"],
        issue_date: parse_date(cert["issue_date"]),
        expiry_date: parse_date(cert["expiry_date"]),
        skills_covered: cert["skills_covered"]
      )
    end
  end

  def generate_candidate_embeddings(candidate)
    @embedding.generate_for_candidate(candidate)
  end

  def parse_date(val)
    return nil if val.blank?
    Date.parse(val)
  rescue ArgumentError
    nil
  end
end
