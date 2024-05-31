class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :cart_id, :quantity, :created_at, :products
  
  attribute :products do |obj|
    object.product.as_json
  end
end