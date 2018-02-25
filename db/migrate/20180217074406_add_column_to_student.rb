class AddColumnToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :register_time, :datetime 
    add_column :students, :account, :string 
  end
end
