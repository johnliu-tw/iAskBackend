class AddPlatformTypeToPaperSets < ActiveRecord::Migration[5.0]
  def change
    add_column :paper_sets, :platform_type, :integer
  end
end
