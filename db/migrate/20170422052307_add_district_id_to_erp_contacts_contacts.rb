class AddDistrictIdToErpContactsContacts < ActiveRecord::Migration[5.0]
  def change
    change_table :erp_contacts_contacts do |t|
      t.references :district, index: true, references: :erp_areas_districts
    end
  end
end
