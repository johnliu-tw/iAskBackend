class AlterQuestionTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :writing_questions
    rename_table :selection_questions, :questions
  end
end
