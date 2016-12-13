class CreateErpContactsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_tags do |t|
      t.string :name
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
