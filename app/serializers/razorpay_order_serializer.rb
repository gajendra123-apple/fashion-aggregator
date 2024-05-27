class RazorpayOrderSerializer < ActiveModel::Serializer
  attributes :id,  :order_id, :amount, :currency, :receipt, :status, :created_at
end