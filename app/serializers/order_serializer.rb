class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_date, :shipping_address, :billing_address, :status, :total_amount
  belongs_to :product
  belongs_to :user
end