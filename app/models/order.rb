class Order < ApplicationRecord
  enum status: { pending: "pending", processed: "processed", delivered: "delivered" }
  belongs_to :user
  belongs_to :product, optional: :true
  belongs_to :cart, optional: :true
  has_many :order_items, dependent: :destroy
  has_many :products, dependent: :destroy

  after_create :update_order_status

  validates :order_date, :shipping_address, :billing_address, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :status, presence: true, inclusion: { in: %w[pending shipped delivered] }

  def self.ransackable_attributes(auth_object = nil)
    ["billing_address", "created_at", "id", "id_value", "order_date", "shipping_address", "status", "total_amount", "updated_at"]
  end

  def update_order_status
    self.update(status: :processed) if pending?
  end
    
  end