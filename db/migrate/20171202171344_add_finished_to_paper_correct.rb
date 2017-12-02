class AddFinishedToPaperCorrect < ActiveRecord::Migration[5.0]
  def change
    remove_column :papers, :finished
    remove_column :papers, :finished_timestamp  
    add_column :student_correct_rates, :finished, :boolean
    add_column :student_correct_rates, :finished_timestamp, :datetime
  end
end
