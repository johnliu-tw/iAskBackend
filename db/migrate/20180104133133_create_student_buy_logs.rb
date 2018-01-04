class CreateStudentBuyLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :student_buy_logs do |t|
      t.string :student_id
      t.string :paper_set_id

      t.timestamps
    end
  end
end
