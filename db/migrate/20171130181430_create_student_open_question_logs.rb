class CreateStudentOpenQuestionLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :student_open_question_logs do |t|
      t.string :question_id
      t.string :student_id

      t.timestamps
    end
  end
end
