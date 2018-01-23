class AddTimestampeToStudentAnswerLog < ActiveRecord::Migration[5.0]
  def change
    # Add timestamps column, but without a NOT NULL constraint
    add_timestamps :student_answer_logs, null: true

    # Backfill missing data with a really old date
    time = Time.zone.parse('2000-01-01 00:00:00')
    update "UPDATE student_answer_logs SET created_at = '#{time}'"
    update "UPDATE student_answer_logs SET updated_at = '#{time}'"

    # Restore NOT NULL constraints to be in line with the Rails default
    change_column_null :student_answer_logs, :created_at, false
    change_column_null :student_answer_logs, :updated_at, false
  end
end
