class WorkOrderProduct < ActiveRecord::Base
  has_one :work_order, inverse_of: :work_order_products
  has_one :product

  attr_accessible :work_order, :product, :fee, :count, :memo, :is_fixed_schedule, :start_date, :end_date, :schedule_unit, :schedule_count

  validates_presence_of :work_order, :product
  # TODO validate schedule details based on is_fixed_schedule
end
