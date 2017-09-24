class AddRelationKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :papersubject_subjectships,:paper_subject_id,:integer
    add_column :papersubject_subjectships,:subject_id,:integer
    add_column :question_paperships,:paper_id,:integer
    add_column :question_paperships,:question_id,:integer
  end
end
