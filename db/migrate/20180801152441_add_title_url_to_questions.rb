class AddTitleUrlToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:title_url,:string
    add_column :questions,:title_url_show_type,:string
    add_column :questions,:analysis_url_show_type,:string
  end
end
