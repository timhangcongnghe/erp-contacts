class CreateErpContactsMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_messages do |t|
      t.text :message
      t.references :contact, index: true, references: :erp_contacts_contacts
      t.references :to_contact, index: true, references: :erp_contacts_contacts, column: :to_contact_id

      t.timestamps
    end
  end
end
