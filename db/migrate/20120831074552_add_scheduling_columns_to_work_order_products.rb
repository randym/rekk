class AddSchedulingColumnsToWorkOrderProducts < ActiveRecord::Migration
  def change
    add_column :work_order_products, :schedule_unit, :string
    add_column :work_order_products, :schedule_count, :integer
    add_column :work_order_products, :start_date, :date
    add_column :work_order_products, :end_date, :date
    add_column :work_order_products, :is_fixed_schedule, :boolean, default: true
  end
end
