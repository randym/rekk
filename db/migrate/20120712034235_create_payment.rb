class CreatePayment < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :work_order_id
      t.integer :billing_address_id
      t.date :payment_deadline
      t.date :paid_on
      t.integer :closing_year
      t.integer :closing_month
      t.text :bill_to
      t.text :memo
      t.timestamps
    end
  end
end
