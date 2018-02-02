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

ActiveRecord::Schema.define(version: 20180201171252) do

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

  create_table "paper_sets", force: :cascade do |t|
    t.string   "title"
    t.integer  "price"
    t.string   "public_date"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "platform_type"
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
    t.string   "paper_set_id"
    t.float    "correct_rate"
    t.float    "finish_rate"
    t.datetime "answer_time"
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
    t.string   "title",               limit: 128
    t.string   "title_attr",          limit: 128
    t.string   "answer",              limit: 128
    t.string   "analysis",            limit: 128
    t.string   "analysis_att",        limit: 128
    t.string   "analysis_url",        limit: 128
    t.string   "question_type",       limit: 128
    t.boolean  "active",              limit: 128
    t.integer  "optionCount",         limit: 128
    t.integer  "answer_count"
    t.integer  "first_correct_count", limit: 128
    t.string   "questionA",           limit: 128
    t.string   "questionA_attr",      limit: 128
    t.string   "questionB",           limit: 128
    t.string   "questionB_attr",      limit: 128
    t.string   "questionC",           limit: 128
    t.string   "questionC_attr",      limit: 128
    t.string   "questionD",           limit: 128
    t.string   "questionD_attr",      limit: 128
    t.string   "questionE",           limit: 128
    t.string   "questionE_attr",      limit: 128
    t.string   "questionF",           limit: 128
    t.string   "questionF_attr",      limit: 128
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "paper_id",            limit: 128
    t.integer  "position",            limit: 128
    t.string   "questionG",           limit: 128
    t.string   "questionG_attr",      limit: 128
    t.string   "questionH",           limit: 128
    t.string   "questionH_attr",      limit: 128
    t.integer  "platform_type",       limit: 128
    t.string   "difficulty_degree",   limit: 128
    t.string   "knowledge_point",     limit: 128
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "sqlite_stat1", id: false, force: :cascade do |t|
    t. "tbl"
    t. "idx"
    t. "stat"
  end

  create_table "student_answer_logs", force: :cascade do |t|
    t.string   "student_id"
    t.string   "question_id"
    t.boolean  "correct"
    t.string   "answer"
    t.integer  "answer_count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "student_ask_teacher_logs", force: :cascade do |t|
    t.string   "question_id"
    t.string   "student_id"
    t.string   "teacher_id"
    t.string   "student_answer"
    t.boolean  "correct"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "student_buy_logs", force: :cascade do |t|
    t.string   "student_id"
    t.string   "paper_set_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "student_correct_rates", force: :cascade do |t|
    t.string   "student_id"
    t.string   "paper_id"
    t.string   "correct_rate"
    t.boolean  "finished"
    t.datetime "finished_timestamp"
  end

  create_table "student_open_paper_logs", force: :cascade do |t|
    t.string   "paper_id"
    t.string   "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_open_question_logs", force: :cascade do |t|
    t.string   "question_id"
    t.string   "student_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "student_paper_logs", force: :cascade do |t|
    t.string   "student_id"
    t.string   "paper_id"
    t.float    "correct_rate"
    t.float    "finish_rate"
    t.integer  "answer_times"
    t.datetime "answer_time",  default: '2000-01-01 00:00:00'
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "students", id: :string, force: :cascade do |t|
    t.string   "name"
    t.string   "years"
    t.string   "grade"
    t.string   "school"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_students_1", unique: true
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

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
