class WorkOrderProduct < ActiveRecord::Base
  has_one :work_order, inverse_of: :work_order_products
  has_one :product

  attr_accessible :work_order_id, :product_id, :fee, :count, :memo

  validates_presence_of :work_order_id, :product_id
end
