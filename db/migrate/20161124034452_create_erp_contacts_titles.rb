class CreateErpContactsTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_titles do |t|
      t.string :title
      t.string :abbreviation
      t.boolean :archive, default: false
      t.references :user, index: true, references: :erp_users

      t.timestamps
    end
  end
end
