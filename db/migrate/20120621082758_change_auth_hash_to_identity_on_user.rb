class ChangeAuthHashToIdentityOnUser < ActiveRecord::Migration
  def up
   change_table :users do |t|
     t.rename :auth_hash, :identity
   end 
  end

  def down
    change_table :users do |t|
      t.rename :identity, :auth_hash
    end
  end
end
