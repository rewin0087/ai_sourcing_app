class Candidate < ApplicationRecord
  belongs_to :user
  has_many :candidate_skills, dependent: :destroy
  has_many :work_experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :certifications, dependent: :destroy

  def full_name
    [first_name, middle_name, last_name].compact.join(" ")
  end

  def skills_summary
    candidate_skills.map { |s| "#{s.name} (#{s.proficiency}, #{s.years_of_exp})" }.join(", ")
  end

  def experience_text
    work_experiences.order(start_date: :desc).map do |w|
      projects = w.work_projects.map { |p| "#{p.project_name}: #{p.description}" }.join(". ")
      "#{w.job_title} at #{w.company_name} (#{w.start_date&.year}-#{w.end_date&.year || 'Present'}): #{w.description}. Projects: #{projects}"
    end.join("\n")
  end

  def embedding_text
    parts = []
    parts << "Name: #{full_name}" if full_name.present?
    parts << "Title: #{current_title}" if current_title.present?
    parts << "About: #{about_me}" if about_me.present?
    parts << "Skills: #{skills_summary}"
    parts << "Experience: #{experience_text}"
    parts.join("\n")
  end
end
