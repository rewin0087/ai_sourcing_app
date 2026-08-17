class JobDescription < ApplicationRecord
  belongs_to :user
  has_many :candidate_job_matches, dependent: :destroy

  has_neighbors :embedding

  validates :raw_text, presence: true

  STATUSES = %w[pending processing completed failed].freeze
  EXPERIENCE_LEVELS = %w[entry mid senior lead].freeze

  def required_skills_list
    Array(required_skills).map { |s| s["name"] || s[:name] }.compact
  end

  def embedding_text
    parts = []
    parts << "Job Title: #{title}" if title.present?
    parts << "Company: #{company_name}" if company_name.present?
    parts << "Summary: #{summary}" if summary.present?
    parts << "Responsibilities: #{responsibilities}" if responsibilities.present?
    parts << "Qualifications: #{qualifications}" if qualifications.present?
    skills = required_skills_list
    parts << "Required Skills: #{skills.join(', ')}" if skills.any?
    parts.join("\n")
  end
end
