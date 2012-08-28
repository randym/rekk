class WorkOrder < ActiveRecord::Base
  belongs_to :author, class_name: 'User', inverse_of: :authored_work_orders
  belongs_to :owner, class_name: 'User', inverse_of: :owned_work_orders
  belongs_to :client, inverse_of: :work_orders
  belongs_to :payment, inverse_of: :work_order, dependent: :delete

  has_many :work_order_products, dependent: :delete_all, inverse_of: :work_order
  has_one :billing_address, through: :payment

  attr_accessible :author_id, :owner_id, :client_id, :payment_type_id,
                  :memo, :work_order_products_attributes, :payment_attributes, :user_pays

  accepts_nested_attributes_for :work_order_products, allow_destroy: true
  accepts_nested_attributes_for :payment

  validates_presence_of :client_id, :owner_id, :author_id
  validates_associated :payment

  default_scope order('created_at desc')

  paginates_per 2

  def user_pays
    self.payment_id.nil? unless new_record?
  end

  def user_pays=(is_user_pays)
    if is_user_pays === 'true' && payment
      payment.destroy
      self.payment = nil
    end
  end

  def self.by_author(user)
    where(author_id: user.id)
  end

  def self.by_owner(user)
    where owner_id: user.id
  end

  def self.by_client(client)
    where client_id: client.id
  end

  def self.by_status(status)
    where status: status
  end
 end
