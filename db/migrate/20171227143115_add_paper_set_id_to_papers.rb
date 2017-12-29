class AddPaperSetIdToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :paper_set_id, :string
  end
end
