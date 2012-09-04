class WorkOrderProduct < ActiveRecord::Base
  has_one :work_order, inverse_of: :work_order_products
  belongs_to :product

  attr_accessible :work_order_id, :product_id, :fee, :count, :memo, :is_fixed_schedule, :start_date, :end_date, :schedule_unit, :schedule_count, :product_picker

  validates_presence_of :work_order_id, :product_id
  # TODO validate schedule details based on is_fixed_schedule

  def product_picker
    return unless self.product
    self.product.picker_string
  end

  def product_picker=(picker_string)
    set_product_from_picker_string(picker_string)
  end

  private

  def set_product_from_picker_string(picker_string)
    unless picker_string
      self.product_id = nil
    else
      self.product_id =  picker_string.split(':').first
    end
  end
end
