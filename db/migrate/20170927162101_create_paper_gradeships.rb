class CreatePaperGradeships < ActiveRecord::Migration[5.0]
  def change
    create_table :paper_gradeships do |t|

      t.timestamps
    end
  end
end
