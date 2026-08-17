class CreateJobDescriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :job_descriptions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :title
      t.string :company_name
      t.string :location
      t.string :employment_type
      t.text :raw_text, null: false
      t.jsonb :parsed_data, default: {}

      # Extracted structured fields
      t.text :summary
      t.text :responsibilities
      t.text :qualifications
      t.text :about_company
      t.jsonb :required_skills, default: []   # [{name, proficiency, years_required, required}]
      t.jsonb :preferred_skills, default: []
      t.string :salary_range
      t.string :experience_level  # entry | mid | senior | lead

      # Status tracking
      t.string :status, default: "pending"  # pending | processing | completed | failed

      # Embedding for candidate matching
      t.column :embedding, :vector, limit: 1536

      t.timestamps
    end

    add_index :job_descriptions, :status
  end
end
