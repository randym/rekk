class AddProductsTable < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.boolean :includes_tax
      t.integer :product_type
      t.boolean :expired, default: false
      t.timestamps
    end
  end
end
