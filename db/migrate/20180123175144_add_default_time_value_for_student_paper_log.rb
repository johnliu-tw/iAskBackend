class AddDefaultTimeValueForStudentPaperLog < ActiveRecord::Migration[5.0]
  def change
    change_column :student_paper_logs, :answer_time,:datetime, :default => "2000-01-01 00:00:00"
  end
end
