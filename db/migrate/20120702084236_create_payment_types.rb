class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    PaymentType.create(name: :invoice)
    PaymentType.create(name: :gmo)
  end

end
