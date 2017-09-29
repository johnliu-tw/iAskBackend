class AddOrderToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:order,:integer
    add_column :questions,:questionG,:string
    add_column :questions,:questionG_attr,:string
    add_column :questions,:questionH,:string
    add_column :questions,:questionH_attr,:string
  end
end
