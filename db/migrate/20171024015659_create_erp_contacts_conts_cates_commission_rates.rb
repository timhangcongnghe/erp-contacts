class CreateErpContactsContsCatesCommissionRates < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_contacts_conts_cates_commission_rates do |t|
      t.references :contact, index: true, references: :erp_contacts_contacts
      t.references :category, index: true, references: :erp_products_products
      t.decimal :rate

      t.timestamps
    end
  end
end
