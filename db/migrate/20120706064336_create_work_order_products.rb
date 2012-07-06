class CreateWorkOrderProducts < ActiveRecord::Migration
  def change
    create_table :work_order_products do |t|
     t.integer :work_order_id, null: false
     t.integer :product_id, null: false
     t.integer :count
     t.integer :fee
     t.text    :memo 
    end
  end
end
