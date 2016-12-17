class AddContactIdToErpUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :erp_users, :contact, index: true, references: :erp_contacts_contacts
  end
end
