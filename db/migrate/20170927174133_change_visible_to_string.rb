class ChangeVisibleToString < ActiveRecord::Migration[5.0]
  def change
    change_column :papers, :visible, :string
  end
end
