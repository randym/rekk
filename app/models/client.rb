class Client < ActiveRecord::Base
  #relations
  has_many :contacts, inverse_of: :client, dependent: :destroy
  has_many :work_orders, inverse_of: :client
  belongs_to :user, inverse_of: :clients

  #
  # attribute whitelist
  attr_accessible :name, 
                  :local_name, 
                  :accounting_code, 
                  :contacts_attributes,
                  :memo,
                  :user_id

  accepts_nested_attributes_for :contacts, 
    allow_destroy: true, 
    reject_if: proc  { |attributes| 
      attributes[:name].blank? || attributes[:email].blank?
    }

  validates_presence_of :user, :name
  validates_uniqueness_of :name

  def self.by_user(user)
    where(user_id:  user.id)
  end

end
