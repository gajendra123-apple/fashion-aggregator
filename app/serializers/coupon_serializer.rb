class CouponSerializer < ActiveModel::Serializer
  attributes :id, :active, :coupon_name, :discount_percentage, :expiration_date, :minimum_purchase_amount,
   :redemption_instructions, :created_at, :updated_at
end