class CreateStudentsLog < ActiveRecord::Migration[5.0]
  def change
    create_table "student_correct_rates", force: :cascade do |t|
      t.string  "student_id"
      t.string  "paper_id"
      t.string  "correct_rate"
    end
    create_table "student_answer_logs", force: :cascade do |t|
      t.string  "student_id"
      t.string  "question_id"
      t.boolean "correct"
    end
  end
end
