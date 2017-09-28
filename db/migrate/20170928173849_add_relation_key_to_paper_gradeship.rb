class AddRelationKeyToPaperGradeship < ActiveRecord::Migration[5.0]
  def change
    add_column :paper_gradeships,:paper_id,:integer
    add_column :paper_gradeships,:grade_id,:integer
  end
end
