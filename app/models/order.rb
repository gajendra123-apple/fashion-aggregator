class Order < ApplicationRecord
  enum status: { pending: "pending", shipped: "shipped", delivered: "delivered" }
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items, dependent: :destroy
 
  validates :order_date, :shipping_address, :billing_address, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :status, presence: true, inclusion: { in: %w[pending shipped delivered] }

  def self.ransackable_attributes(auth_object = nil)
    ["billing_address", "created_at", "id", "id_value", "order_date", "shipping_address", "status", "total_amount", "updated_at"]
  end
end