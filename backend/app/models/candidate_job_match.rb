class CandidateJobMatch < ApplicationRecord
  belongs_to :candidate
  belongs_to :job_description

  validates :candidate_id, uniqueness: { scope: :job_description_id }
end
