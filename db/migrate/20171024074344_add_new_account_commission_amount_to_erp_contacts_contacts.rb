class AddNewAccountCommissionAmountToErpContactsContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_contacts_contacts, :new_account_commission_amount, :decimal
  end
end
