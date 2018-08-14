class CreatePaperSetPapersships < ActiveRecord::Migration[5.0]
  def change
    create_table :paper_set_papersships do |t|
      t.integer :paper_set_id
      t.integer :paper_id

      t.timestamps
    end
  end
end
