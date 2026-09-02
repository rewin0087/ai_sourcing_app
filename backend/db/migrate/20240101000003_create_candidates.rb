class CreateCandidates < ActiveRecord::Migration[7.2]
  def change
    create_table :candidates do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      # Personal details
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.text :about_me
      t.string :current_title
      t.string :linkedin_url
      t.string :github_url
      t.string :portfolio_url
      t.string :resume_url

      # Profile embedding stored as JSON array (1536 floats); cosine similarity computed in Ruby
      t.json :profile_embedding

      t.timestamps
    end

    add_index :candidates, :email
  end
end
