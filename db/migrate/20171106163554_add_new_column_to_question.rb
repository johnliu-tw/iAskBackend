class AddNewColumnToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:difficulty_degree,:string
    add_column :questions,:knowledge_point, :string
  end
end
