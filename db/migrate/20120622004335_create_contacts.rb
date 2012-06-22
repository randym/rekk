class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :client_id
      t.string :name
      t.string :email
      t.string :division
      t.string :phone
      t.timestamps
    end
  end
end
