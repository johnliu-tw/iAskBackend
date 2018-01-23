class AddRateColumnsToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :correct_rate, :float
    add_column :papers, :finish_rate, :float
    add_column :papers, :answer_time, :datetime
  end
end
