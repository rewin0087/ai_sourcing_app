class WorkProject < ApplicationRecord
  belongs_to :work_experience

  validates :project_name, presence: true
end
