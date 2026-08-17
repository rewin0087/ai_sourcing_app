class Certification < ApplicationRecord
  belongs_to :candidate

  validates :certificate_name, presence: true
end
