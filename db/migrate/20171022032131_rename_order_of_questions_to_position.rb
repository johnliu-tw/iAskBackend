class RenameOrderOfQuestionsToPosition < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :order, :position
  end
end
