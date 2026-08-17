class CreateWorkProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :work_projects do |t|
      t.references :work_experience, null: false, foreign_key: true

      t.string :project_name, null: false
      t.integer :project_status, default: 1  # 0=active, 1=completed
      t.text :description
      t.text :skills_used  # comma-separated skill names
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
