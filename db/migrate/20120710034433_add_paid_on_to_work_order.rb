class AddPaidOnToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :paid_on, :date

  end
end
