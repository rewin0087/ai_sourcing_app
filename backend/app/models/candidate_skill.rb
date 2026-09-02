class CandidateSkill < ApplicationRecord
  belongs_to :candidate

  PROFICIENCY_LEVELS = %w[Beginner Intermediate Advanced].freeze
  YEARS_OF_EXP = ["Less than 5 years", "5 - 10 years", "More than 10 years"].freeze
  SKILL_TYPES = %w[Primary Secondary Tertiary].freeze
  CATEGORIES = ["Languages", "Backend", "Frontend", "Databases", "Cloud & DevOps", "Testing", "Source Control", "AI & LLM Tools", "Other"].freeze

  validates :name, presence: true
  validates :proficiency, inclusion: { in: PROFICIENCY_LEVELS }, allow_blank: true
  validates :skill_type, inclusion: { in: SKILL_TYPES }, allow_blank: true

  def embedding_text
    [
      name,
      category,
      proficiency,
      years_of_exp,
      "#{years_of_exp_in_months} months experience",
      "skill type: #{skill_type}"
    ].compact.join(", ")
  end
end
