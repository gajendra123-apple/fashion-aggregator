class OrderItem < ApplicationRecord
    belongs_to :product
    belongs_to :shoppingcart
    belongs_to :order
end