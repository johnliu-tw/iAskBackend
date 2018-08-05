class AddPaperSourceIdToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers,:paper_source_id,:integer
  end
end
