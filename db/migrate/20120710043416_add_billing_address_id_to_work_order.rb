class AddBillingAddressIdToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :billing_address_id, :integer

  end
end
