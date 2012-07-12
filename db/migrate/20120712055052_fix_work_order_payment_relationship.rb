class FixWorkOrderPaymentRelationship < ActiveRecord::Migration
  def change
    add_column :work_orders, :payment_id, :integer
    remove_column :payments, :work_order_id
  end

end
