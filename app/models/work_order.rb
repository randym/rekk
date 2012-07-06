class WorkOrder < ActiveRecord::Base
  belongs_to :author, class_name: 'User', inverse_of: :authored_work_orders
  belongs_to :owner, class_name: 'User', inverse_of: :owned_work_orders
  belongs_to :client, inverse_of: :work_orders
  belongs_to :payment_type
  has_many :work_order_products, dependent: :delete_all, inverse_of: :work_order

  attr_accessible :author_id, :owner_id, :client_id, :payment_type_id, :memo, :work_order_products_attributes

  accepts_nested_attributes_for :work_order_products, allow_destroy: true

  validates_presence_of :client_id, :owner_id, :author_id, :payment_type_id

  def self.by_author(user)
    where(author_id: user.id)
  end

  def self.by_owner(user)
    where owner_id: user.id
  end

  def self.by_client(client)
    where client_id: client.id
  end

end
