class AddPlatformTypeToPaperSources < ActiveRecord::Migration[5.0]
  def change
    add_column :paper_sources,:platform_type,:integer
  end
end
