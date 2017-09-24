class CreateQuestionPaperships < ActiveRecord::Migration[5.0]
  def change
    create_table :question_paperships do |t|
      t.integer :order

      t.timestamps
    end
  end
end
