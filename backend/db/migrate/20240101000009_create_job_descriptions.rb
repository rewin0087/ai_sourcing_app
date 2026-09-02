class CreateJobDescriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :job_descriptions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :title
      t.string :company_name
      t.string :location
      t.string :employment_type
      t.text :raw_text, null: false
      t.json :parsed_data

      # Extracted structured fields
      t.text :summary
      t.text :responsibilities
      t.text :qualifications
      t.text :about_company
      t.json :required_skills   # [{name, proficiency, years_required, required}]
      t.json :preferred_skills
      t.string :salary_range
      t.string :experience_level  # entry | mid | senior | lead

      # Status tracking
      t.string :status, default: "pending"  # pending | processing | completed | failed

      # Embedding stored as JSON array (1536 floats); cosine similarity computed in Ruby
      t.json :embedding

      t.timestamps
    end

    add_index :job_descriptions, :status
  end
end
