class CreateCandidateJobMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :candidate_job_matches do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job_description, null: false, foreign_key: true

      t.float :similarity_score, default: 0.0
      t.float :skill_match_score, default: 0.0
      t.float :experience_match_score, default: 0.0
      t.float :overall_score, default: 0.0
      t.integer :rank
      t.text :ai_reasoning
      t.json :matched_skills
      t.json :missing_skills

      t.timestamps
    end

    add_index :candidate_job_matches, [:candidate_id, :job_description_id], unique: true, name: "idx_candidate_job_unique"
    add_index :candidate_job_matches, :overall_score
  end
end
