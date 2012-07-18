class AddStatusToWorkOrder < ActiveRecord::Migration
  def change
    # the dba in me screams Nooooooooooo dont do this!
    # wonder if I will ever end up migrating this into a work_order_status table...
    add_column :work_orders, :status, :string, :default => 'new'
  end
end
