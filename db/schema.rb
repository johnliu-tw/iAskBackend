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

ActiveRecord::Schema.define(version: 20170928173849) do

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "selection_questions", force: :cascade do |t|
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
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "writing_questions", force: :cascade do |t|
    t.string   "title"
    t.string   "title_attr"
    t.string   "analysis"
    t.string   "analysis_att"
    t.string   "analysis_url"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "paper_id"
  end

end
