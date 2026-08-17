class CreateEducations < ActiveRecord::Migration[7.2]
  def change
    create_table :educations do |t|
      t.references :candidate, null: false, foreign_key: true

      t.string :school_name, null: false
      t.string :degree_obtained
      t.string :field_of_study
      t.date :start_date
      t.date :end_date
      t.boolean :still_studying, default: false
      t.text :description

      t.timestamps
    end
  end
end
