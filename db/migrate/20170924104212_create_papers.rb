class CreatePapers < ActiveRecord::Migration[5.0]
  def change
    create_table :papers do |t|
      t.string :title
      t.boolean :active
      t.integer :visible
      t.string :public_date
      t.string :note
      t.integer :grade
      t.integer :open_count
      t.integer :correct_count

      t.timestamps
    end
  end
end
