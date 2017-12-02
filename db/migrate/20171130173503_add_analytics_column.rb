class AddAnalyticsColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :papers,:finished,:boolean
    add_column :papers,:finished_timestamp,:datetime
    
  end
end
