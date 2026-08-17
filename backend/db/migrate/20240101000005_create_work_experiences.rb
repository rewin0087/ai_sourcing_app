class CreateWorkExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :work_experiences do |t|
      t.references :candidate, null: false, foreign_key: true

      t.string :company_name, null: false
      t.string :job_title, null: false
      t.integer :work_status, default: 0  # 0=past, 1=current
      t.integer :employment_type, default: 1  # 1=Full-time, 2=Part-time, 3=Contract
      t.string :location
      t.integer :location_type, default: 1  # 1=On-site, 2=Remote, 3=Hybrid
      t.text :description
      t.date :start_date
      t.date :end_date

      # Embedding of the combined job experience for vector search
      t.column :embedding, :vector, limit: 1536

      t.timestamps
    end

    add_index :work_experiences, :work_status
  end
end
