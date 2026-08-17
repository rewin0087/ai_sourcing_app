class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  ROLES = %w[candidate sourcer admin].freeze

  has_one :candidate, dependent: :destroy
  has_many :job_descriptions, dependent: :destroy

  validates :role, inclusion: { in: ROLES }
  after_create :create_candidate_profile, if: :candidate?

  def candidate?
    role == "candidate"
  end

  def sourcer?
    role == "sourcer"
  end

  def admin?
    role == "admin"
  end

  private

  def create_candidate_profile
    create_candidate!
  end
end
