class CreateErpContactsContactGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_contact_groups do |t|
      t.string :name
      t.decimal :discount, default: 0.00
      t.string :discount_type
      t.text :note
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
