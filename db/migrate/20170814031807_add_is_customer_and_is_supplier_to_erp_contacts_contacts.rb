class AddIsCustomerAndIsSupplierToErpContactsContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_contacts_contacts, :is_customer, :boolean, default: false
    add_column :erp_contacts_contacts, :is_supplier, :boolean, default: false
  end
end
