class AddJobTitleToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :job_title, :string
  end
end
