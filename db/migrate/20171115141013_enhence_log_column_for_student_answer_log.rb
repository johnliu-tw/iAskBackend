class EnhenceLogColumnForStudentAnswerLog < ActiveRecord::Migration[5.0]
  def change
    add_column :student_answer_logs,:answer,:string
    add_column :student_answer_logs,:answer_count,:integer    
  end
end
