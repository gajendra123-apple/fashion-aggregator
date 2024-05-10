class OrderItem < ApplicationRecord
    # belongs_to :product
    # belongs_to :shoppingcart
    # belongs_to :order

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "price", "quantity", "updated_at"]
  end
end