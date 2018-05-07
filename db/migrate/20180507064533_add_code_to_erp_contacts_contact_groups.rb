class AddCodeToErpContactsContactGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_contacts_contact_groups, :code, :string
  end
end
