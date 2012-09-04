class Product < ActiveRecord::Base
  #relations
  has_one :product_type, inverse_of: :products

  #attribute whitelist
  attr_accessible :name, :price, :includes_tax, :product_type_id, :expired

  validates_presence_of :name, :price 

  scope :active, where(expired: false)

  def picker_string
    "#{id}: #{name} #{price}"
  end

end
