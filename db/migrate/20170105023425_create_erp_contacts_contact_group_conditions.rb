class CreateErpContactsContactGroupConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_contact_group_conditions do |t|
      t.string :name
      t.string :operator
      t.string :value
      t.references :contact_group, index: true, references: :erp_contacts_contact_groups

      t.timestamps
    end
  end
end
