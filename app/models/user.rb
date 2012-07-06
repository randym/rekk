class User < ActiveRecord::Base
  has_many :roles, :through => :user_roles 
  has_many :clients, dependent: :destroy
  attr_accessible :name, :email, :identity
  has_many :authored_work_orders, foreign_key: :author_id, class_name: :work_order
  has_many :owned_work_orders, foreign_key: :owner_id, class_name: :owrk_order
  accepts_nested_attributes_for :roles 

  validates_presence_of :name, :email, :identity

  validates_uniqueness_of :email 
  
  def self.authenticate(omniauth_auth)
    omniauth = OmniauthParser.new(omniauth_auth)
    user = User.find_or_create_by_email(omniauth.email)
    user.update_attributes(omniauth.user_hash)
    user
  end
end
