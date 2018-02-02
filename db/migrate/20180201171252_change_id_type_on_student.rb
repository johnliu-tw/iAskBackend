class ChangeIdTypeOnStudent < ActiveRecord::Migration[5.0]
  def change
    change_column :students, :id, :string, null: false, unique: true
  end
end
