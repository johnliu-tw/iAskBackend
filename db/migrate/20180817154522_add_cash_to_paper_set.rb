class AddCashToPaperSet < ActiveRecord::Migration[5.0]
  def change
    add_column :paper_sets,:cash,:integer
  end
end
