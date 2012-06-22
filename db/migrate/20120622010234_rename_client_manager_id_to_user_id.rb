class RenameClientManagerIdToUserId < ActiveRecord::Migration
  def change
    change_table :clients do |t|
     t.rename :client_manager_id, :user_id 
    end
  end
end
