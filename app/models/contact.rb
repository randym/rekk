class Contact < ActiveRecord::Base
  belongs_to :client
  attr_accessible :name, :email, :division, :phone, :client_id, :job_title
end
