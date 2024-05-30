class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :total_price, :created_at,:updated_at
  has_many :cart_items, serializer: CartItemSerializer

  # def total_sum
  #   object.total_price
  # end
end