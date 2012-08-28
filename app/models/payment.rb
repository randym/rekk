class Payment < ActiveRecord::Base
  attr_accessible :bill_to, :closing_year, :closing_month, :payment_deadline, :paid_on, :billing_address_id
  has_one :work_order, inverse_of: :payment

  validates :bill_to, :closing_year, :closing_month, :payment_deadline, :billing_address_id, presence: true
  validate :payment_deadline_must_be_in_the_future, on: :update
  def self.allowed_closing_years
    (2006..(Time.zone.now.year+1)).to_a
  end

  private

  def payment_deadline_must_be_in_the_future
    if payment_deadline < Date.today
      errors.add(:payment_deadline, 'must be in the future')
    end
  end

end
