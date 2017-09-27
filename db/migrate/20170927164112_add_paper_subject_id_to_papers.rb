class AddPaperSubjectIdToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers,:paper_subject_id,:integer
  end
end
