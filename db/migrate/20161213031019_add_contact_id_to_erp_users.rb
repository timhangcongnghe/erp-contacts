class AddContactIdToErpUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_users, :contact_id, :integer
  end
end
