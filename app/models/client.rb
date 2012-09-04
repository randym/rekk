class Client < ActiveRecord::Base
  #relations
  has_many :contacts, inverse_of: :client, dependent: :destroy
  has_many :work_orders, inverse_of: :client
  belongs_to :user, inverse_of: :clients
  has_many :billing_addresses, inverse_of: :client, dependent: :destroy
  #
  # attribute whitelist
  attr_accessible :name, 
                  :local_name, 
                  :accounting_code, 
                  :contacts_attributes,
                  :memo,
                  :user_id,
                  :billing_addresses_attributes

  accepts_nested_attributes_for :contacts, 
    allow_destroy: true, 
    reject_if: proc  { |attributes| 
      attributes[:name].blank? || attributes[:email].blank?
    }
  
  accepts_nested_attributes_for :billing_addresses,
    allow_destroy: true,
    reject_if: proc { |attributes|
      attributes[:postal_code].blank? || attributes[:address_1].blank?
    }

  validates_presence_of :user, :name
  validates_uniqueness_of :name

  def self.by_user(user)
    where(user_id:  user.id)
  end


end
