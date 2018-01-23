class AddRateToStudentOpenPaperLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :student_open_paper_logs, :correct_rate, :float
    add_column :student_open_paper_logs, :finish_rate, :float
    add_column :student_open_paper_logs, :answer_time, :datetime
  end
end
