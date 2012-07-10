class RenamePaymentDealineToPaymentDeadline < ActiveRecord::Migration
  def change 
    rename_column :work_orders, :payment_dealine, :payment_deadline
  end
end
