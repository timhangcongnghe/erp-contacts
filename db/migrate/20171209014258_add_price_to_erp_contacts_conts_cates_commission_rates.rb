class AddPriceToErpContactsContsCatesCommissionRates < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_contacts_conts_cates_commission_rates, :price, :decimal
  end
end
