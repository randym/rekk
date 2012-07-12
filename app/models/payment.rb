class Payment < ActiveRecord::Base
  attr_accessible :bill_to, :closing_year, :closing_month, :payment_deadline, :paid_on, :billing_address_id
  has_one :work_order, inverse_of: :payment
  def self.allowed_closing_years
    (2006..(Time.zone.now.year+1)).to_a
  end


end
