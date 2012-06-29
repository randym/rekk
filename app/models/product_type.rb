class ProductType < ActiveRecord::Base
  #relations
  has_many :products, inverse_of: :product_type

  # attribute whitelist
  attr_accessible :name, :expired

  validates_presence_of :name

  scope :active, where(expired: false)
end
