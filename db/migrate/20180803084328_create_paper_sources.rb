class CreatePaperSources < ActiveRecord::Migration[5.0]
  def change
    create_table :paper_sources do |t|
      t.string :name

      t.timestamps
    end
  end
end
