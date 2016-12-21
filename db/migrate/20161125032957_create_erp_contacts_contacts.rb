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
      t.string :tax
      t.string :gender
      t.string :email
      t.datetime :birthday
      t.text :internal_note
      t.boolean :is_customer, default: false
      t.boolean :is_vendor, default: false
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      t.references :title, index: true, references: :erp_contacts_titles
      t.references :country, index: true, references: :erp_areas_countries
      t.references :state, index: true, references: :erp_areas_states
      t.references :parent, index: true, references: :erp_contacts_contacts
      t.references :company, index: true, references: :erp_contacts_contacts
      t.references :salesperson, index: true, references: :erp_users

      t.timestamps
    end
  end
end
