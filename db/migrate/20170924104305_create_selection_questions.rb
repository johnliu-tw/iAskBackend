class CreateSelectionQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :selection_questions do |t|
      t.string :title
      t.string :title_attr
      t.string :answer
      t.string :analysis
      t.string :analysis_att
      t.string :analysis_url
      t.string :question_type
      t.boolean :active
      t.integer :optionCount
      t.integer :answer_count
      t.integer :first_correct_count
      t.string :questionA
      t.string :questionA_attr
      t.string :questionB
      t.string :questionB_attr
      t.string :questionC
      t.string :questionC_attr
      t.string :questionD
      t.string :questionD_attr
      t.string :questionE
      t.string :questionE_attr
      t.string :questionF
      t.string :questionF_attr

      t.timestamps
    end
  end
end
