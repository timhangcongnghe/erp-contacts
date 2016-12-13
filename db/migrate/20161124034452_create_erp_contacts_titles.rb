class CreateErpContactsTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_contacts_titles do |t|
      t.string :name
      t.string :abbreviation
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
