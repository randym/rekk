class ChangeProductProductTypeColumnName < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.rename :product_type, :product_type_id
    end
  end
end
