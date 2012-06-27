class ProductType < ActiveRecord::Base
  #relations
  has_many :products, inverse_of: :product_type

  # attribute whitelist
  attr_accessible :name, :expired

  def self.active
    self.where(expired: false)
  end  
end
