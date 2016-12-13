class CreateErpContactsContactsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_contacts_tags do |t|
      t.references :contact, index: true, references: :erp_contacts_contacts
      t.references :tag, index: true, references: :erp_contacts_tags
    end
  end
end
