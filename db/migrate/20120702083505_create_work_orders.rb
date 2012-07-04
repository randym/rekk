class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|
      t.integer :author_id, null: false
      t.integer :owner_id, null: false
      t.integer :client_id, null: false
      t.integer :payment_type_id, null: false
      t.text :memo
      t.timestamps
    end
  end
end
