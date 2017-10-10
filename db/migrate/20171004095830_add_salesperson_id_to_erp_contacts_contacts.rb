class AddSalespersonIdToErpContactsContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :erp_contacts_contacts, :salesperson, index: true, references: :erp_users
  end
end
