require "csv"

class CsvExportService
  # Dispatches to the correct CSV generator based on report type.
  # Returns a CSV string ready to stream.
  def generate(type, data)
    case type.to_s
    when "candidates"       then candidates_csv(data)
    when "skill_report"     then skill_report_csv(data)
    when "experience_report" then experience_report_csv(data)
    when "role_distribution" then role_distribution_csv(data)
    when "database_summary"  then database_summary_csv(data)
    when "top_skills_by_category" then top_skills_csv(data)
    else raise ArgumentError, "Unknown export type: #{type}"
    end
  end

  private

  def candidates_csv(candidates)
    CSV.generate(headers: true) do |csv|
      csv << ["ID", "Full Name", "Current Title", "Location", "Experience (yrs)", "Email", "Top Skills"]
      Array(candidates).each do |c|
        skills = Array(c[:skills]).first(8).map { |s| "#{s[:name]} (#{s[:proficiency]})" }.join("; ")
        csv << [
          c[:id],
          c[:full_name],
          c[:current_title],
          c[:location],
          c[:total_experience_years],
          c[:email],
          skills
        ]
      end
    end
  end

  def skill_report_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << ["Metric", "Value"]
      csv << ["Skill Query", data[:skill_query]]
      csv << ["Candidates with Skill", data[:total_candidates_with_skill]]
      csv << ["Total Skill Entries", data[:total_skill_entries]]
      avg_years = data[:avg_months_experience].to_f / 12.0
      csv << ["Avg Experience (yrs)", avg_years.round(1)]
      csv << ["With Certification", data[:with_certification]]
      csv << []
      csv << ["Proficiency", "Count"]
      data[:by_proficiency].each { |prof, count| csv << [prof, count] }
      csv << []
      csv << ["Years of Exp Range", "Count"]
      data[:by_years_of_exp].each { |yr, count| csv << [yr, count] }
      csv << []
      csv << ["Sample Candidates (ID)", "Name", "Title", "Proficiency", "Years"]
      Array(data[:sample_candidates]).each do |c|
        csv << [c[:id], c[:name], c[:title], c[:proficiency], c[:years]]
      end
    end
  end

  def experience_report_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << ["Level", "Count"]
      data[:levels].each { |level, count| csv << [level, count] }
      csv << []
      csv << ["Average Experience", "#{data[:average_years]} years"]
    end
  end

  def role_distribution_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << ["Role / Function", "Candidate Count"]
      data.each { |role, count| csv << [role, count] }
    end
  end

  def database_summary_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << ["Section", "Label", "Value"]
      csv << ["Overview", "Total Candidates", data[:total_candidates]]
      csv << []
      csv << ["Experience Levels", "Level", "Count"]
      data[:experience_levels].each { |level, count| csv << ["", level, count] }
      csv << []
      csv << ["Role Distribution", "Role", "Count"]
      data[:role_distribution].each { |role, count| csv << ["", role, count] }
      csv << []
      csv << ["Top Skills", "Skill", "Count"]
      data[:top_skills].each { |skill, count| csv << ["", skill, count] }
    end
  end

  def top_skills_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << ["Category", "Skill", "Candidate Count"]
      data.each do |category, skills|
        skills.each { |name, count| csv << [category, name, count] }
      end
    end
  end
end
