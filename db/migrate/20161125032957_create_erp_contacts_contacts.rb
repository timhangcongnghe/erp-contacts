class CreateErpContactsContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_contacts do |t|

      t.timestamps
    end
  end
end
