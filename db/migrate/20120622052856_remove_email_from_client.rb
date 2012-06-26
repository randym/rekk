class RemoveEmailFromClient < ActiveRecord::Migration
  def change
      remove_column :clients, :email
  end
end
