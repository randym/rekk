class Role < ActiveRecord::Base
  has_many :users, :through => :user_roles
end
