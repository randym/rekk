class AddPaymentDeadlineToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :payment_dealine, :date

  end
end
