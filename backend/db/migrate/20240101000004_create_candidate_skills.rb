class CreateCandidateSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :candidate_skills do |t|
      t.references :candidate, null: false, foreign_key: true

      t.string :name, null: false
      t.string :category
      t.string :proficiency  # Beginner | Intermediate | Advanced
      t.string :years_of_exp # Less than 5 years | 5 - 10 years | More than 10 years
      t.integer :years_of_exp_in_months, default: 0
      t.string :skill_type   # Primary | Secondary | Tertiary
      t.integer :year_last_used
      t.string :certification, default: "No" # Yes | No
      t.string :delivered_projects # Less than 5 | 5 - 10 | More than 10

      # Embedding stored as JSON array (1536 floats)
      t.json :embedding

      t.timestamps
    end

    add_index :candidate_skills, [:candidate_id, :name], unique: true
  end
end
