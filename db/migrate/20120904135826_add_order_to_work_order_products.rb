class AddOrderToWorkOrderProducts < ActiveRecord::Migration
  def change
    add_column :work_order_products, :position, :integer
  end
end
