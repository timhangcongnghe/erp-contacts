class CreateErpContactsContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_contacts do |t|
      t.string :image_url
      t.string :contact_type
      t.string :code
      t.string :name
      t.string :company_name
      t.string :phone
      t.string :address
      t.string :tax_code
      t.datetime :birthday
      t.string :email
      t.string :gender
      t.text :note
      t.string :fax
      t.string :website
      t.decimal :commission_percent
      t.boolean :archived, default: false
      t.references :parent, index: true, references: :erp_contacts_contacts
      t.references :company, index: true, references: :erp_contacts_contacts
      t.references :tag, index: true, references: :erp_contacts_tags
      t.references :user, index: true, references: :erp_users
      t.references :creator, index: true, references: :erp_users
      t.references :contact_group, index: true, references: :erp_contacts_contact_groups
      
      t.references :country, index: true, references: :erp_areas_countries
      t.references :state, index: true, references: :erp_areas_states
      t.references :price_term, index: true, references: :erp_currencies_price_terms
      t.references :tax, index: true, references: :erp_taxes_taxes
      t.references :payment_method, index: true, references: :erp_payments_payment_method
      t.references :payment_term, index: true, references: :erp_payments_payment_terms
      
      t.timestamps
    end
  end
end
