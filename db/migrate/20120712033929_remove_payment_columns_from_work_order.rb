class RemovePaymentColumnsFromWorkOrder < ActiveRecord::Migration
  def change
    remove_column :work_orders, :billing_address_id, :paid_on, :bill_to, :closing_month, :closing_year, :payment_deadline, :payment_type_id
  end
end
