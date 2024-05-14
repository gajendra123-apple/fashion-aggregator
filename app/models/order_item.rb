class OrderItem < ApplicationRecord
    # belongs_to :product
    # belongs_to :shoppingcart
    # belongs_to :order

  validates :quantity,  presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "price", "quantity", "updated_at"]
  end
end