class WorkOrderProduct < ActiveRecord::Base
  belongs_to :work_order, inverse_of: :work_order_products
  belongs_to :product
  before_save :set_position_on_new_records
  attr_accessible :work_order_id, :postiion, :product_id, :fee, :count, :memo, :is_fixed_schedule, :start_date, :end_date, :schedule_unit, :schedule_count, :product_picker

  validates_presence_of :work_order_id, :product_id, :fee, :count
  # TODO validate schedule details based on is_fixed_schedule
  default_scope order('position asc')

  def product_picker
    return unless self.product
    self.product.picker_string
  end

  def schedule
    if is_fixed_schedule?
       "#{start_date} - #{end_date}"
    else
      "#{schedule_count} months"
    end
  end
  def is_fixed_schedule?
    is_fixed_schedule
  end

  def product_picker=(picker_string)
    set_product_from_picker_string(picker_string)
  end

  private

  def set_position_on_new_records
    if self.new_record?
      self.position = work_order.work_order_products.size
    end
  end

  def set_product_from_picker_string(picker_string)
    unless picker_string
      self.product_id = nil
    else
      self.product_id =  picker_string.split(':').first
    end
  end
end
