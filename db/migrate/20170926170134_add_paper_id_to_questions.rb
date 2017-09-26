class AddPaperIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :selection_questions,:paper_id,:integer
    add_column :writing_questions,:paper_id,:integer
  end
end
