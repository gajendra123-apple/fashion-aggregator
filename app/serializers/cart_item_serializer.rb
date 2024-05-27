class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :cart_id, :products,  :quantity, :created_at
  
  attribute :products do |obj|
    object.product.as_json
  end
end