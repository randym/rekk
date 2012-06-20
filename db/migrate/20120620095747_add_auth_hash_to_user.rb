class AddAuthHashToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :auth_hash
    end
  end
end
