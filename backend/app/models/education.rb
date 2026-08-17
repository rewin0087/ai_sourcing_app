class Education < ApplicationRecord
  belongs_to :candidate

  validates :school_name, presence: true
end
