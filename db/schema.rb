# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_16_195627) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.date "comment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entry_id"
    t.index ["entry_id"], name: "index_comments_on_entry_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "vacancy_id"
    t.integer "candidate_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.integer "label"
    t.integer "status"
    t.index ["candidate_id"], name: "index_entries_on_candidate_id"
    t.index ["vacancy_id"], name: "index_entries_on_vacancy_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entry_id"
    t.index ["entry_id"], name: "index_feedbacks_on_entry_id"
  end

  create_table "headhunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_headhunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_headhunters_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.string "education"
    t.string "description"
    t.string "experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "candidate_id"
    t.index ["candidate_id"], name: "index_profiles_on_candidate_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.date "start_date"
    t.string "workload"
    t.string "benefits"
    t.string "wage"
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "candidate_id"
    t.integer "entry_id"
    t.integer "status"
    t.integer "headhunter_id"
    t.index ["candidate_id"], name: "index_proposals_on_candidate_id"
    t.index ["entry_id"], name: "index_proposals_on_entry_id"
    t.index ["headhunter_id"], name: "index_proposals_on_headhunter_id"
  end

  create_table "reports", force: :cascade do |t|
    t.text "body"
    t.integer "proposal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_reports_on_proposal_id"
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "skill"
    t.string "wage"
    t.string "role"
    t.date "end_date"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "headhunter_id"
    t.integer "status"
    t.index ["headhunter_id"], name: "index_vacancies_on_headhunter_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "entries"
  add_foreign_key "entries", "candidates"
  add_foreign_key "entries", "vacancies"
  add_foreign_key "feedbacks", "entries"
  add_foreign_key "profiles", "candidates"
  add_foreign_key "proposals", "candidates"
  add_foreign_key "proposals", "entries"
  add_foreign_key "proposals", "headhunters"
  add_foreign_key "reports", "proposals"
  add_foreign_key "vacancies", "headhunters"
end
