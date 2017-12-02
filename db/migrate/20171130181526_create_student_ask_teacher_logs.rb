class CreateStudentAskTeacherLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :student_ask_teacher_logs do |t|
      t.string :question_id
      t.string :student_id
      t.string :teacher_id
      t.string :student_answer
      t.boolean :correct

      t.timestamps
    end
  end
end
