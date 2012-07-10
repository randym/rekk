class BillingAddress < ActiveRecord::Base
  belongs_to :client, inverse_of: :billing_addresses
  attr_accessible :client_id, :postal_code, :address_1, :address_2, :address_3, :company_name, :recipient_name, :recipient_title
  validates_presence_of :postal_code, :company_name, :client_id
end
