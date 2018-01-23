class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :years
      t.string :grade
      t.string :school

      t.timestamps
    end
  end
end
