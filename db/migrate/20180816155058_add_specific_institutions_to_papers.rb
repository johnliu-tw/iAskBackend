class AddSpecificInstitutionsToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers,:specific_institution,:string
    add_column :papers,:specific_institution_visible,:boolean
  end
end
