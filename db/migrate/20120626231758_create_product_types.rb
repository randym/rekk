class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.boolean :expired, default: false
      t.timestamps
    end
  end
end
