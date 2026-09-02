class CandidateJobMatch < ApplicationRecord
  belongs_to :candidate
  belongs_to :job_description

  attribute :matched_skills, :json, default: []
  attribute :missing_skills, :json, default: []

  validates :candidate_id, uniqueness: { scope: :job_description_id }
end
