class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :product_id, uniqueness: { scope: :cart_id, message: "can only be added once to the cart" }
end