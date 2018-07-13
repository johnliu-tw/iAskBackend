class AddOpenQuestionIdToAnswerLog < ActiveRecord::Migration[5.0]
  def change
    add_column :student_answer_logs,:student_open_question_log_id,:integer
  end
end
