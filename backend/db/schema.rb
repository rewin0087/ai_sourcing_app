# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_01_01_000010) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "candidate_job_matches", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.bigint "job_description_id", null: false
    t.float "similarity_score", default: 0.0
    t.float "skill_match_score", default: 0.0
    t.float "experience_match_score", default: 0.0
    t.float "overall_score", default: 0.0
    t.integer "rank"
    t.text "ai_reasoning"
    t.jsonb "matched_skills", default: []
    t.jsonb "missing_skills", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id", "job_description_id"], name: "idx_candidate_job_unique", unique: true
    t.index ["candidate_id"], name: "index_candidate_job_matches_on_candidate_id"
    t.index ["job_description_id"], name: "index_candidate_job_matches_on_job_description_id"
    t.index ["overall_score"], name: "index_candidate_job_matches_on_overall_score"
  end

  create_table "candidate_skills", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "name", null: false
    t.string "category"
    t.string "proficiency"
    t.string "years_of_exp"
    t.integer "years_of_exp_in_months", default: 0
    t.string "skill_type"
    t.integer "year_last_used"
    t.string "certification", default: "No"
    t.string "delivered_projects"
    t.vector "embedding", limit: 1536
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id", "name"], name: "index_candidate_skills_on_candidate_id_and_name", unique: true
    t.index ["candidate_id"], name: "index_candidate_skills_on_candidate_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.text "about_me"
    t.string "current_title"
    t.string "linkedin_url"
    t.string "github_url"
    t.string "portfolio_url"
    t.string "resume_url"
    t.vector "profile_embedding", limit: 1536
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_candidates_on_email"
    t.index ["user_id"], name: "index_candidates_on_user_id", unique: true
  end

  create_table "certifications", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "certificate_name", null: false
    t.string "issuing_org"
    t.date "issue_date"
    t.date "expiry_date"
    t.text "skills_covered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_certifications_on_candidate_id"
  end

  create_table "educations", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "school_name", null: false
    t.string "degree_obtained"
    t.string "field_of_study"
    t.date "start_date"
    t.date "end_date"
    t.boolean "still_studying", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_educations_on_candidate_id"
  end

  create_table "job_descriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "company_name"
    t.string "location"
    t.string "employment_type"
    t.text "raw_text", null: false
    t.jsonb "parsed_data", default: {}
    t.text "summary"
    t.text "responsibilities"
    t.text "qualifications"
    t.text "about_company"
    t.jsonb "required_skills", default: []
    t.jsonb "preferred_skills", default: []
    t.string "salary_range"
    t.string "experience_level"
    t.string "status", default: "pending"
    t.vector "embedding", limit: 1536
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_job_descriptions_on_status"
    t.index ["user_id"], name: "index_job_descriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role", default: "candidate", null: false
    t.string "full_name"
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_experiences", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "company_name", null: false
    t.string "job_title", null: false
    t.integer "work_status", default: 0
    t.integer "employment_type", default: 1
    t.string "location"
    t.integer "location_type", default: 1
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.vector "embedding", limit: 1536
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_work_experiences_on_candidate_id"
    t.index ["work_status"], name: "index_work_experiences_on_work_status"
  end

  create_table "work_projects", force: :cascade do |t|
    t.bigint "work_experience_id", null: false
    t.string "project_name", null: false
    t.integer "project_status", default: 1
    t.text "description"
    t.text "skills_used"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_experience_id"], name: "index_work_projects_on_work_experience_id"
  end

  add_foreign_key "candidate_job_matches", "candidates"
  add_foreign_key "candidate_job_matches", "job_descriptions"
  add_foreign_key "candidate_skills", "candidates"
  add_foreign_key "candidates", "users"
  add_foreign_key "certifications", "candidates"
  add_foreign_key "educations", "candidates"
  add_foreign_key "job_descriptions", "users"
  add_foreign_key "work_experiences", "candidates"
  add_foreign_key "work_projects", "work_experiences"
end
