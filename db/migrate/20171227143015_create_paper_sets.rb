class CreatePaperSets < ActiveRecord::Migration[5.0]
  def change
    create_table :paper_sets do |t|
      t.string :title
      t.integer :price
      t.string :public_date
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
