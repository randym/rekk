class RemoveEmailFromClient < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.remove_column :email
    end
  end
end
