class CreatePaperSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :paper_subjects do |t|
      t.string :title
      t.string :title_view
      t.boolean :active

      t.timestamps
    end
  end
end
