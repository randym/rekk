class WorkOrder < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :owner, class_name: 'User'
  belongs_to :client
  belongs_to :payment_type

  attr_accessible :author_id, :owner_id, :client_id, :payment_type_id, :memo
end
