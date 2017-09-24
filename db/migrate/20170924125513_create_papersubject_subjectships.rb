class CreatePapersubjectSubjectships < ActiveRecord::Migration[5.0]
  def change
    create_table :papersubject_subjectships do |t|

      t.timestamps
    end
  end
end
