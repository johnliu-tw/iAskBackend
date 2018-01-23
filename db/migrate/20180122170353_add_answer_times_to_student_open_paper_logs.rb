class AddAnswerTimesToStudentOpenPaperLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :student_open_paper_logs, :answer_times, :integer
  end
end
