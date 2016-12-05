class CreateErpContactsContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_contacts do |t|
      t.string :name
      t.string :image_url
      t.string :contact_type
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :zip
      t.string :website
      t.string :job_position
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :email
      t.string :birthday
      t.text :internal_note
      t.boolean :archived, default: false
      t.references :user, index: true, references: :erp_users
      t.references :title, index: true, references: :erp_contacts_titles

      t.timestamps
    end
  end
end
