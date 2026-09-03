class CandidateAnalyticsService
  ROLE_PATTERNS = [
    # ── Technology & Engineering (IT) ────────────────────────────────────────
    ["Backend Engineer",          /backend|api[\s\-]?dev|server[\s\-]?side|rails\s|django|laravel|spring\s|fastapi/i],
    ["Frontend Engineer",         /frontend|front[\s\-]?end|ui[\s\-]?dev|react[\s\-]?dev|vue[\s\-]?dev|angular[\s\-]?dev/i],
    ["Full Stack Engineer",       /full[\s\-]?stack/i],
    ["Mobile Engineer",           /mobile\s?dev|\bios\s?dev|android\s?dev|\bflutter\b|react\s?native/i],
    ["DevOps \/ SRE",             /devops|site\s?reliability|platform\s?eng|cloud\s?eng|\bsre\b|infrastructure\s?eng/i],
    ["Cloud \/ Solutions Architect", /cloud\s?arch|solutions\s?arch|enterprise\s?arch|system\s?arch/i],
    ["Data Science \/ ML \/ AI",  /data\s?sci|machine\s?learn|\bml\s?eng|ai\s?eng|deep\s?learn|\bnlp\b|computer\s?vision|llm/i],
    ["Data Engineer",             /data\s?eng|etl|data\s?pipeline|analytics\s?eng/i],
    ["Data Analyst",              /data\s?anal|business\s?intel|\bbi\s?analyst|reporting\s?anal/i],
    ["Database Administrator",    /\bdba\b|database\s?admin/i],
    ["QA \/ Test Engineer",       /\bqa\b|\bqe\b|quality\s?ass|test\s?eng|\bsdet\b|automation\s?eng/i],
    ["Security Engineer",         /security\s?eng|infosec|pen\s?test|cybersec|information\s?sec/i],
    ["Network Engineer",          /network\s?eng|network\s?admin|systems\s?admin|\bsysadmin\b|it\s?infra/i],
    ["IT Support \/ Helpdesk",    /it\s?support|help\s?desk|helpdesk|technical\s?support|desktop\s?support/i],
    ["Embedded \/ Firmware",      /embedded|firmware|iot\s?eng|hardware\s?eng/i],
    ["Game Developer",            /game\s?dev|unity\s?dev|unreal\s?dev/i],
    ["Blockchain \/ Web3",        /blockchain|web3|solidity|smart\s?contract|crypto\s?dev/i],
    ["UI \/ UX Designer",         /ui\s?designer|ux\s?designer|ui\/ux|product\s?design|interaction\s?design/i],
    ["Engineering Manager",       /eng.*manager|vp.*eng|head.*eng|director.*eng|engineering\s?lead/i],
    ["Tech Lead",                 /tech\s?lead|technical\s?lead|lead\s?eng|lead\s?dev|principal\s?eng|staff\s?eng/i],
    ["Software Engineer",         /software\s?eng|software\s?dev|\bprogrammer\b|\bdeveloper\b/i],

    # ── Product & Design ─────────────────────────────────────────────────────
    ["Product Manager",           /product\s?manager|product\s?owner|\bproduct\s?mgr\b/i],
    ["Program \/ Project Manager", /program\s?manager|\bpmo\b|project\s?manager|project\s?coord/i],
    ["Scrum Master \/ Agile",     /scrum\s?master|agile\s?coach|release\s?train/i],
    ["Graphic \/ Visual Designer",/graphic\s?design|visual\s?design|brand\s?design|creative\s?design/i],
    ["Industrial Designer",       /industrial\s?design|product\s?design\s?mech/i],
    ["Architect \/ Interior",     /interior\s?design|landscape\s?arch|\barchitect\b/i],

    # ── Business, Strategy & Consulting ──────────────────────────────────────
    ["CEO \/ C-Suite Executive",  /\bceo\b|\bcoo\b|\bcmo\b|\bcso\b|chief\s?exec|chief\s?operat|chief\s?market|president/i],
    ["CTO \/ CIO \/ CISO",        /\bcto\b|\bcio\b|\bciso\b|chief\s?tech|chief\s?info|chief\s?security/i],
    ["CFO \/ Finance Executive",  /\bcfo\b|chief\s?fin/i],
    ["VP \/ Director",            /\bvp\b|vice\s?pres|\bdirector\b|\bhead\s?of\b/i],
    ["General Manager",           /general\s?manager|\bgm\b\s|managing\s?director/i],
    ["Business Analyst",          /business\s?anal|process\s?anal|functional\s?anal/i],
    ["Management Consultant",     /management\s?consul|strategy\s?consul|mckinsey|deloitte\s?consul/i],
    ["Strategy \/ Operations",    /strategy\s?manager|chief\s?of\s?staff|biz\s?ops|business\s?ops/i],

    # ── Finance & Accounting ─────────────────────────────────────────────────
    ["Accountant \/ Bookkeeper",  /accountant|bookkeeper|accounts\s?payable|accounts\s?receiv|comptroller/i],
    ["Financial Analyst",         /financial\s?anal|fp&a|financial\s?plan|investment\s?anal/i],
    ["Investment Banking \/ VC",  /investment\s?bank|equity\s?research|portfolio\s?manager|venture\s?cap|private\s?equity/i],
    ["Auditor",                   /\bauditor\b|internal\s?audit|external\s?audit/i],
    ["Tax Specialist",            /tax\s?spec|tax\s?consul|tax\s?account|transfer\s?pric/i],
    ["Risk \/ Compliance",        /risk\s?manager|compliance\s?officer|risk\s?analyst|aml\s?analyst|kyc\s?analyst/i],
    ["Insurance",                 /insurance\s?agent|insurance\s?broker|underwriter|actuary|claims\s?adj/i],
    ["Treasurer \/ Controller",   /treasurer|controller\b|finance\s?manager|finance\s?controller/i],

    # ── Human Resources & Talent ──────────────────────────────────────────────
    ["HR \/ People Operations",   /\bhr\b|human\s?res|people\s?ops|hris|hr\s?business\s?partner/i],
    ["Recruiter \/ Talent Acq",   /recruit|talent\s?acq|sourcer|headhunt|talent\s?partner/i],
    ["L&D \/ Training",           /learning\s?&\s?dev|l&d|training\s?spec|corporate\s?trainer|instructional\s?design/i],
    ["Compensation \/ Benefits",  /compensation|total\s?rewards|benefits\s?admin|payroll/i],

    # ── Sales ────────────────────────────────────────────────────────────────
    ["Sales Manager \/ Director", /sales\s?manager|sales\s?director|regional\s?sales|national\s?sales/i],
    ["Account Executive \/ AE",   /account\s?exec|\bae\b\s|sales\s?rep|sales\s?exec/i],
    ["Business Development",      /business\s?dev|biz\s?dev|partnerships\s?manager/i],
    ["Customer Success",          /customer\s?success|client\s?success|customer\s?experience\s?manager/i],
    ["Pre-Sales \/ Solutions Eng",/pre[\s\-]?sales|solutions\s?eng|sales\s?eng/i],
    ["Retail \/ Store",           /store\s?manager|retail\s?manager|shop\s?manager|branch\s?manager/i],

    # ── Marketing & Communications ────────────────────────────────────────────
    ["Marketing Manager",         /marketing\s?manager|growth\s?manager|demand\s?gen/i],
    ["Digital \/ Performance Mktg",/digital\s?market|performance\s?market|paid\s?media|sem\s?spec|ppc\s?spec/i],
    ["SEO \/ Content Marketing",  /\bseo\b|\bsem\b|content\s?market|content\s?strat/i],
    ["Social Media",              /social\s?media|community\s?manager|influencer/i],
    ["Brand \/ Creative",         /brand\s?manager|brand\s?strat|creative\s?direct/i],
    ["Copywriter \/ Content",     /copywriter|content\s?writer|technical\s?writer|copy\s?editor/i],
    ["Public Relations",          /public\s?relat|\bpr\s?manager|\bpr\s?spec|communications\s?manager|media\s?relat/i],
    ["Video \/ Media Production", /video\s?producer|film\s?maker|motion\s?graphic|cinematographer|media\s?prod/i],
    ["Event \/ Experience",       /event\s?manager|event\s?planner|event\s?coord|conference\s?manager/i],

    # ── Customer Service & Support ────────────────────────────────────────────
    ["Customer Service \/ Support",/customer\s?serv|customer\s?support|help\s?desk\s?agent|call\s?center|support\s?spec|support\s?rep|service\s?desk/i],
    ["Client Relations",          /client\s?relat|account\s?manager|client\s?services/i],

    # ── Legal ─────────────────────────────────────────────────────────────────
    ["Lawyer \/ Attorney",        /lawyer|attorney|\badvocate\b|barrister|solicitor|legal\s?counsel/i],
    ["Paralegal \/ Legal Assist", /paralegal|legal\s?assist|legal\s?coord/i],
    ["Compliance Officer",        /compliance\s?officer|regulatory\s?affairs|legal\s?compliance/i],
    ["Contract Manager",          /contract\s?manager|contract\s?admin/i],

    # ── Engineering (Non-IT) ─────────────────────────────────────────────────
    ["Civil \/ Structural Eng",   /civil\s?eng|structural\s?eng|geotechnical|highway\s?eng/i],
    ["Mechanical Engineer",       /mechanical\s?eng|manufacturing\s?eng|tooling\s?eng|production\s?eng/i],
    ["Electrical \/ Electronics", /electrical\s?eng|electronics\s?eng|power\s?eng|control\s?eng/i],
    ["Chemical Engineer",         /chemical\s?eng|process\s?eng|refinery\s?eng/i],
    ["Aerospace \/ Defense",      /aerospace\s?eng|aeronautical|avionics|defense\s?eng/i],
    ["Environmental Engineer",    /environmental\s?eng|sustainability\s?eng|environmental\s?consul/i],
    ["Quality Engineer",          /quality\s?eng|quality\s?manager|\biso\b\s?auditor|six\s?sigma/i],

    # ── Operations, Supply Chain & Logistics ─────────────────────────────────
    ["Operations Manager",        /operations\s?manager|ops\s?manager|plant\s?manager|site\s?manager/i],
    ["Supply Chain \/ Procurement",/supply\s?chain|procurement|sourcing\s?manager|purchasing\s?manager/i],
    ["Logistics \/ Distribution", /logistics|distribution\s?manager|warehouse\s?manager|freight/i],
    ["Manufacturing \/ Production",/manufacturing|production\s?manager|production\s?supervisor|assembly/i],
    ["Quality Control",           /quality\s?control|quality\s?assurance\s?manager|inspection\s?manager/i],

    # ── Science & Research ───────────────────────────────────────────────────
    ["Research Scientist",        /research\s?sci|scientist|research\s?fellow|r&d\s?manager/i],
    ["Lab Technician",            /lab\s?tech|laboratory\s?tech|lab\s?analyst|lab\s?manager/i],
    ["Biologist \/ Chemist",      /biologist|chemist|biochemist|microbiologist|pharmacologist/i],
    ["Clinical Research",         /clinical\s?res|clinical\s?trial|medical\s?research|cro\s?manager/i],

    # ── Healthcare & Medical ─────────────────────────────────────────────────
    ["Doctor \/ Physician",       /physician|doctor|\bmd\b\s|general\s?practitioner|specialist\s?doc/i],
    ["Surgeon",                   /surgeon|surgical\s?spec/i],
    ["Nurse \/ Nursing",          /\bnurse\b|nursing|registered\s?nurse|\brn\b\s|\blpn\b/i],
    ["Pharmacist",                /pharmacist|pharmacy\s?manager/i],
    ["Dentist \/ Dental",         /dentist|dental\s?surgeon|orthodontist/i],
    ["Therapist \/ Counselor",    /therapist|counselor|psychologist|psychiatrist|mental\s?health/i],
    ["Physical \/ Occupational Therapy", /physical\s?therap|occupational\s?therap|physiotherapy/i],
    ["Healthcare Admin",          /healthcare\s?admin|hospital\s?admin|medical\s?admin|clinic\s?manager/i],
    ["Paramedic \/ EMT",          /paramedic|\bemt\b|emergency\s?med|first\s?responder/i],

    # ── Education & Training ─────────────────────────────────────────────────
    ["Professor \/ Academic",     /professor|lecturer|associate\s?prof|academic\s?res/i],
    ["Teacher \/ Instructor",     /teacher|instructor|\beducator\b|school\s?teach|faculty/i],
    ["School Administrator",      /school\s?admin|principal|dean|academic\s?director|registrar/i],
    ["Curriculum Developer",      /curriculum|instructional\s?design|e[\s\-]?learning\s?dev/i],
    ["Tutor \/ Coach",            /\btutor\b|\bcoach\b|personal\s?trainer|fitness\s?coach|life\s?coach/i],

    # ── Real Estate & Construction ────────────────────────────────────────────
    ["Real Estate Agent \/ Broker",/real\s?estate\s?agent|realtor|property\s?broker|leasing\s?agent/i],
    ["Property Manager",          /property\s?manager|estate\s?manager|facilities\s?manager/i],
    ["Construction Manager",      /construction\s?manager|site\s?supervisor|building\s?manager/i],
    ["Urban Planner",             /urban\s?plan|city\s?planner|land\s?use/i],

    # ── Hospitality, Food & Travel ────────────────────────────────────────────
    ["Hotel \/ Hospitality Manager",/hotel\s?manager|hospitality\s?manager|resort\s?manager|front\s?office\s?manager/i],
    ["Chef \/ Food Service",      /\bchef\b|head\s?chef|sous\s?chef|executive\s?chef|food\s?service/i],
    ["Restaurant Manager",        /restaurant\s?manager|food\s?bev\s?manager|bar\s?manager/i],
    ["Travel \/ Tourism",         /travel\s?agent|tour\s?operator|tourism\s?manager|travel\s?consultant/i],
    ["Flight Crew \/ Aviation",   /pilot|\bcabin\s?crew\b|flight\s?attendant|aviation\s?manager/i],

    # ── Public Sector, Non-Profit & Social ───────────────────────────────────
    ["Government \/ Public Admin",/government|civil\s?serv|public\s?admin|policy\s?analyst|municipal/i],
    ["Social Worker",             /social\s?worker|case\s?manager|community\s?worker|welfare\s?officer/i],
    ["Non-Profit \/ NGO",         /non[\s\-]?profit|ngo\s|charity\s?manager|foundation\s?manager/i],
    ["Military \/ Defense",       /military\s?officer|\barmy\b|\bnavy\b|\bair\s?force\b|defense\s?analyst/i],

    # ── Media, Arts & Entertainment ───────────────────────────────────────────
    ["Journalist \/ Editor",      /journalist|reporter|editor|news\s?anchor|correspondent/i],
    ["Photographer \/ Videographer",/photographer|videographer|cinematographer|photo\s?editor/i],
    ["Actor \/ Performer",        /\bactor\b|performer|entertainer|voice\s?artist/i],
    ["Musician \/ Artist",        /musician|composer|artist|illustrator|animator/i],

    # ── Agriculture & Environment ─────────────────────────────────────────────
    ["Agronomist \/ Farm Manager",/agronomist|farm\s?manager|agricultural\s?eng|crop\s?sci/i],
    ["Environmental \/ Sustainability", /environmental\s?manager|sustainability\s?manager|ecology|conservation/i],

    # ── Transportation & Skilled Trades ──────────────────────────────────────
    ["Driver \/ Transport",       /\bdriver\b|truck\s?driver|delivery\s?driver|transport\s?coord/i],
    ["Electrician \/ Technician", /electrician|plumber|hvac\s?tech|maintenance\s?tech|field\s?tech/i],

    # ── Fallback ─────────────────────────────────────────────────────────────
    ["Engineer (General)",        /\bengineer\b/i],
    ["Manager (General)",         /\bmanager\b/i],
    ["Analyst (General)",         /\banalyst\b/i],
    ["Specialist (General)",      /\bspecialist\b/i],
    ["Coordinator",               /\bcoordinator\b|\bcoord\b/i],
    ["Consultant",                /\bconsultant\b/i],
    ["Associate \/ Officer",      /\bassociate\b|\bofficer\b/i],
    ["Intern \/ Trainee",         /\bintern\b|\btrainee\b|graduate\s?program/i],
  ].freeze

  include VectorSimilarity

  def initialize
    @ai = FuelixService.new
  end

  # ── Overview ───────────────────────────────────────────────────────────────

  def database_summary
    total = Candidate.count
    skill_categories = CandidateSkill.group(:category).count.sort_by { |_, v| -v }.to_h
    top_skills = CandidateSkill.group(:name).order("count_all DESC").limit(15).count

    {
      total_candidates: total,
      experience_levels: experience_level_counts,
      role_distribution: role_distribution_counts.first(8).to_h,
      skill_categories: skill_categories,
      top_skills: top_skills
    }
  end

  # ── Experience & Roles ─────────────────────────────────────────────────────

  def experience_report
    {
      levels: experience_level_counts,
      average_years: average_experience_years
    }
  end

  def role_distribution
    role_distribution_counts.to_h
  end

  # ── Skills ─────────────────────────────────────────────────────────────────

  def skill_report(skill_name)
    matching = CandidateSkill.where("LOWER(name) LIKE ?", "%#{skill_name.downcase}%")

    {
      skill_query: skill_name,
      total_candidates_with_skill: matching.select(:candidate_id).distinct.count,
      total_skill_entries: matching.count,
      by_proficiency: matching.group(:proficiency).count,
      by_years_of_exp: matching.group(:years_of_exp).count,
      avg_months_experience: matching.average(:years_of_exp_in_months)&.round || 0,
      with_certification: matching.where(certification: "Yes").count,
      sample_candidates: matching.includes(:candidate).limit(5).map { |s|
        c = s.candidate
        { id: c.id, name: c.full_name, title: c.current_title, proficiency: s.proficiency, years: s.years_of_exp }
      }
    }
  end

  def top_skills_by_category(limit: 10)
    CandidateSkill::CATEGORIES.each_with_object({}) do |cat, result|
      top = CandidateSkill
        .where(category: cat)
        .group(:name)
        .order("count_all DESC")
        .limit(limit)
        .count
      result[cat] = top unless top.empty?
    end
  end

  # ── Candidate Search ───────────────────────────────────────────────────────

  def search_candidates(query, limit: 8)
    query_embedding = @ai.embed(query)
    return [] unless query_embedding

    scope = Candidate.includes(:candidate_skills, :work_experiences)
    results = vector_search(scope, :profile_embedding, query_embedding, limit: limit)
    results.map { |r| candidate_summary(r[:record]) }
  rescue StandardError => e
    Rails.logger.error("[CandidateAnalyticsService] search_candidates failed: #{e.message}")
    []
  end

  def get_candidate(id)
    c = Candidate
      .includes(:candidate_skills, :educations, :certifications, work_experiences: :work_projects)
      .find(id)

    total_months = c.work_experiences.sum { |w| experience_months(w) }

    {
      id: c.id,
      full_name: c.full_name,
      current_title: c.current_title,
      email: c.email,
      location: [c.city, c.state, c.country].compact.join(", "),
      about_me: c.about_me,
      total_experience_years: (total_months / 12.0).round(1),
      skills: c.candidate_skills.order(years_of_exp_in_months: :desc).map { |s|
        { name: s.name, proficiency: s.proficiency, years: s.years_of_exp, category: s.category }
      },
      work_experiences: c.work_experiences.order(start_date: :desc).map { |w|
        {
          company: w.company_name,
          title: w.job_title,
          duration: w.duration_text,
          description: w.description&.truncate(300),
          projects: w.work_projects.map { |p| { name: p.project_name, skills: p.skills_used } }
        }
      },
      educations: c.educations.map { |e|
        { school: e.school_name, degree: e.degree_obtained, field: e.field_of_study }
      },
      certifications: c.certifications.map { |cert|
        { name: cert.certificate_name, org: cert.issuing_org }
      }
    }
  rescue ActiveRecord::RecordNotFound
    nil
  end

  # ── CSV Export ─────────────────────────────────────────────────────────────

  # Returns a signed, URL-safe token embedding the export parameters.
  # The token uses urlsafe Base64 (no +, /, = characters) so it survives
  # being embedded in URLs, HTML, and LLM responses without encoding issues.
  def export_csv(type:, **params)
    build_export_data(type, params)  # validate early before issuing token

    payload = { type: type.to_s, params: params.transform_keys(&:to_s), expires_at: 15.minutes.from_now.to_i }
    token = verifier.generate(payload)

    {
      token:        token,
      filename:     export_filename(type, params),
      download_url: "/api/v1/sourcing/exports/csv?token=#{token}",
      record_count: nil,
      expires_in:   "15 minutes"
    }
  end

  # Called by ExportsController — verifies the signed token and generates the CSV.
  def self.generate_csv_from_token(raw_token)
    payload = verifier.verify(raw_token)
    payload = payload.transform_keys(&:to_sym) if payload.respond_to?(:transform_keys)
    raise "Export link has expired." if Time.now.to_i > payload[:expires_at].to_i

    type   = payload[:type].to_s
    params = (payload[:params] || {}).transform_keys(&:to_sym)

    svc = new
    data, filename = svc.send(:build_export_data, type, params)
    csv  = CsvExportService.new.generate(type, data)
    { csv: csv, filename: filename }
  rescue ActiveSupport::MessageVerifier::InvalidSignature,
         ActiveSupport::MessageVerifier::InvalidMessage
    nil
  rescue StandardError => e
    Rails.logger.error("[CandidateAnalyticsService] generate_csv_from_token failed: #{e.message}")
    nil
  end

  private

  def verifier
    self.class.verifier
  end

  def self.verifier
    secret = Rails.application.key_generator.generate_key("csv_export", 32)
    ActiveSupport::MessageVerifier.new(secret, serializer: JSON)
  end

  def export_filename(type, params)
    case type.to_s
    when "candidates"     then "candidates_#{params[:query].to_s.parameterize.truncate(30, omission: '')}.csv"
    when "skill_report"   then "skill_report_#{params[:skill].to_s.parameterize}.csv"
    when "experience_report" then "experience_report.csv"
    when "role_distribution" then "role_distribution.csv"
    when "database_summary"  then "database_summary.csv"
    when "top_skills_by_category" then "top_skills_by_category.csv"
    else "export.csv"
    end
  end

  def build_export_data(type, params)
    case type.to_s
    when "candidates"
      query = params[:query].to_s.strip
      limit = (params[:limit] || 50).to_i.clamp(1, 200)
      raise ArgumentError, "'query' is required for candidates export" if query.blank?
      data = search_candidates(query, limit: limit)
      [data, "candidates_#{query.parameterize.truncate(30, omission: '')}.csv"]

    when "skill_report"
      skill = params[:skill].to_s.strip
      raise ArgumentError, "'skill' is required for skill_report export" if skill.blank?
      data = skill_report(skill)
      [data, "skill_report_#{skill.parameterize}.csv"]

    when "experience_report"
      [experience_report, "experience_report.csv"]

    when "role_distribution"
      [role_distribution, "role_distribution.csv"]

    when "database_summary"
      [database_summary, "database_summary.csv"]

    when "top_skills_by_category"
      limit = (params[:limit] || 10).to_i
      [top_skills_by_category(limit: limit), "top_skills_by_category.csv"]

    else
      raise ArgumentError, "Unknown export type '#{type}'. Valid types: candidates, skill_report, experience_report, role_distribution, database_summary, top_skills_by_category"
    end
  end

  def candidate_summary(c)
    total_months = c.work_experiences.sum { |w| experience_months(w) }
    {
      id: c.id,
      full_name: c.full_name,
      current_title: c.current_title,
      location: [c.city, c.country].compact.join(", "),
      skills: c.candidate_skills.order(years_of_exp_in_months: :desc).limit(8).map { |s|
        { name: s.name, proficiency: s.proficiency }
      },
      total_experience_years: (total_months / 12.0).round(1)
    }
  end

  def experience_months(work_exp)
    start = work_exp.start_date
    return 0 unless start

    finish = work_exp.end_date || Date.today
    ((finish.year * 12 + finish.month) - (start.year * 12 + start.month)).clamp(0, Float::INFINITY).to_i
  end

  def experience_level_counts
    sql = <<~SQL
      SELECT level, COUNT(*) AS count
      FROM (
        SELECT c.id,
          CASE
            WHEN COALESCE(total_months, 0) < 24  THEN 'Junior (0-2 yrs)'
            WHEN total_months              < 60  THEN 'Mid-level (2-5 yrs)'
            WHEN total_months              < 120 THEN 'Senior (5-10 yrs)'
            ELSE                                      'Lead / Principal (10+ yrs)'
          END AS level
        FROM candidates c
        LEFT JOIN (
          SELECT candidate_id,
            SUM(
              CASE
                WHEN end_date IS NOT NULL
                  THEN TIMESTAMPDIFF(MONTH, start_date, end_date)
                ELSE  TIMESTAMPDIFF(MONTH, start_date, CURDATE())
              END
            ) AS total_months
          FROM work_experiences
          WHERE start_date IS NOT NULL
          GROUP BY candidate_id
        ) exp ON exp.candidate_id = c.id
      ) lvls
      GROUP BY level
      ORDER BY count DESC
    SQL

    result = ActiveRecord::Base.connection.select_all(sql)
    result.each_with_object({}) { |row, h| h[row["level"]] = row["count"].to_i }
  rescue StandardError
    {}
  end

  def average_experience_years
    sql = <<~SQL
      SELECT AVG(total_months) / 12.0 AS avg_years
      FROM (
        SELECT candidate_id,
          SUM(
            CASE
              WHEN end_date IS NOT NULL
                THEN TIMESTAMPDIFF(MONTH, start_date, end_date)
              ELSE  TIMESTAMPDIFF(MONTH, start_date, CURDATE())
            END
          ) AS total_months
        FROM work_experiences
        WHERE start_date IS NOT NULL
        GROUP BY candidate_id
      ) exp
    SQL

    result = ActiveRecord::Base.connection.select_all(sql)
    result.first&.fetch("avg_years", 0).to_f.round(1)
  rescue StandardError
    0
  end

  def role_distribution_counts
    titles = Candidate.where.not(current_title: [nil, ""]).pluck(:current_title)
    counts = Hash.new(0)
    titles.each { |t| counts[classify_role(t)] += 1 }
    counts["Unclassified"] = Candidate.where(current_title: [nil, ""]).count
    counts.delete("Unclassified") if counts["Unclassified"] == 0
    counts.sort_by { |_, v| -v }
  end

  def classify_role(title)
    ROLE_PATTERNS.each { |label, pattern| return label if title.match?(pattern) }
    "Other"
  end
end
