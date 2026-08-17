class WorkExperience < ApplicationRecord
  belongs_to :candidate
  has_many :work_projects, dependent: :destroy

  has_neighbors :embedding

  validates :company_name, :job_title, presence: true

  EMPLOYMENT_TYPES = { 1 => "Full-time", 2 => "Part-time", 3 => "Contract" }.freeze
  LOCATION_TYPES = { 1 => "On-site", 2 => "Remote", 3 => "Hybrid" }.freeze

  def current?
    work_status == 1
  end

  def duration_text
    start = start_date&.strftime("%b %Y") || "Unknown"
    finish = current? ? "Present" : end_date&.strftime("%b %Y") || "Unknown"
    "#{start} - #{finish}"
  end

  def embedding_text
    parts = []
    parts << "#{job_title} at #{company_name}"
    parts << duration_text
    parts << description if description.present?
    work_projects.each { |p| parts << "Project: #{p.project_name} - #{p.description}" }
    parts.join(". ")
  end
end
