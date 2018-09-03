class AddRoleIdToDatas < ActiveRecord::Migration[5.0]
  def change
    add_column :paper_sets,:role_id,:integer
    add_column :grades,:role_id,:integer
    add_column :paper_sources,:role_id,:integer
    add_column :papers,:role_id,:integer
    add_column :paper_subjects,:role_id,:integer
    add_column :subjects,:role_id,:integer
  end
end
