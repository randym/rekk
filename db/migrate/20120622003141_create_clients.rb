class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :local_name
      t.string :accounting_code
      t.integer :client_manager_id
      # t.client_rep goes into a separate table so clients can have more than one rep
      # t.billing_x billing info goes into a seperate table as well
      t.text :memo
      t.string :email

      t.timestamps
    end
  end
end
