class Order < ApplicationRecord
    enum status: { pending: "pending", shipped: "shipped", delivered: "delivered" }
    belongs_to :user
    has_many :order_items
    has_many :products, through: :order_items

  def self.ransackable_attributes(auth_object = nil)
    ["billing_address", "created_at", "id", "id_value", "order_date", "shipping_address", "status", "total_amount", "updated_at"]
  end
end