class User < ActiveRecord::Base
  has_many :roles, :through => :user_roles 
  attr_accessible :name, :email, :auth_hash
  accepts_nested_attributes_for :roles 
end
