class Client < ActiveRecord::Base
  has_many :contacts
  belongs_to :user
  attr_accessible :name, :local_name, :accounting_code, :user, :contacts, :memo
  accepts_nested_attributes_for :contacts, allow_destroy: true
end
