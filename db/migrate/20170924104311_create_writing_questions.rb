class CreateWritingQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :writing_questions do |t|
      t.string :title
      t.string :title_attr
      t.string :analysis
      t.string :analysis_att
      t.string :analysis_url
      t.boolean :active

      t.timestamps
    end
  end
end
