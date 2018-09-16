class AlterRoleIdOnTables < ActiveRecord::Migration[5.0]
  def change
    remove_column :subjects, :role_id
    remove_column :grades, :role_id
    remove_column :paper_subjects, :role_id
    remove_column :paper_subjects, :role_id
    add_column :papers,:team_id,:integer    
  end
end
