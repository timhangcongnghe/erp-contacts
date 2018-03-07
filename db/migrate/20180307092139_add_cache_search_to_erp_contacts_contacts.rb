class AddCacheSearchToErpContactsContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_contacts_contacts, :cache_search, :text
  end
end
