# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171003135348) do

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "platform_type"
  end

  create_table "paper_gradeships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "paper_id"
    t.integer  "grade_id"
  end

  create_table "paper_subjects", force: :cascade do |t|
    t.string   "title"
    t.string   "title_view"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "platform_type"
  end

  create_table "papers", force: :cascade do |t|
    t.string   "title"
    t.boolean  "active"
    t.string   "visible"
    t.string   "public_date"
    t.string   "note"
    t.integer  "grade"
    t.integer  "open_count"
    t.integer  "correct_count"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "paper_subject_id"
    t.integer  "platform_type"
  end

  create_table "papersubject_subjectships", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "paper_subject_id"
    t.integer  "subject_id"
  end

  create_table "question_paperships", force: :cascade do |t|
    t.integer  "order"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "paper_id"
    t.integer  "question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.string   "title_attr"
    t.string   "answer"
    t.string   "analysis"
    t.string   "analysis_att"
    t.string   "analysis_url"
    t.string   "question_type"
    t.boolean  "active"
    t.integer  "optionCount"
    t.integer  "answer_count"
    t.integer  "first_correct_count"
    t.string   "questionA"
    t.string   "questionA_attr"
    t.string   "questionB"
    t.string   "questionB_attr"
    t.string   "questionC"
    t.string   "questionC_attr"
    t.string   "questionD"
    t.string   "questionD_attr"
    t.string   "questionE"
    t.string   "questionE_attr"
    t.string   "questionF"
    t.string   "questionF_attr"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "paper_id"
    t.integer  "order"
    t.string   "questionG"
    t.string   "questionG_attr"
    t.string   "questionH"
    t.string   "questionH_attr"
    t.integer  "platform_type"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "platform_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
