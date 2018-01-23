class AlterStudentOpenPaperLogs < ActiveRecord::Migration[5.0]
  def change
    remove_column :student_open_paper_logs, :correct_rate
    remove_column :student_open_paper_logs, :finish_rate
    remove_column :student_open_paper_logs, :answer_times
    remove_column :student_open_paper_logs, :answer_time

    create_table :student_paper_logs do |t|
      t.string "student_id"
      t.string "paper_id"
      t.float "correct_rate"
      t.float "finish_rate"
      t.integer "answer_times"
      t.datetime "answer_time"

      t.timestamps
    end
  end
end
