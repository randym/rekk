class DropPaymentType < ActiveRecord::Migration
  def change
    drop_table :payment_types
  end
end
