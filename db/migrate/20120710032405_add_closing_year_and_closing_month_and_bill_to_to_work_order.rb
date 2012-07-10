class AddClosingYearAndClosingMonthAndBillToToWorkOrder < ActiveRecord::Migration
  def change
    add_column :work_orders, :closing_year, :integer

    add_column :work_orders, :closing_month, :integer

    add_column :work_orders, :bill_to, :text

  end
end
