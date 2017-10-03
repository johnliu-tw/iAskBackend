class AddPlatformTypeToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:platform_type,:integer
    add_column :grades,:platform_type,:integer
    add_column :paper_subjects,:platform_type,:integer
    add_column :papers,:platform_type,:integer
    add_column :subjects,:platform_type,:integer
  end
end
