class CreateBillingAddress < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.integer :client_id, null: false
      t.string :postal_code, null: false
      t.string :address_1, null: false
      t.string :address_2
      t.string :address_3
      t.string :company_name
      t.string :recipient_name
      t.string :recipient_title
      t.timestamps
    end
  end
end
