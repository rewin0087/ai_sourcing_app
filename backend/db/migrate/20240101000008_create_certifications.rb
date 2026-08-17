class CreateCertifications < ActiveRecord::Migration[7.2]
  def change
    create_table :certifications do |t|
      t.references :candidate, null: false, foreign_key: true

      t.string :certificate_name, null: false
      t.string :issuing_org
      t.date :issue_date
      t.date :expiry_date
      t.text :skills_covered  # comma-separated skill names

      t.timestamps
    end
  end
end
