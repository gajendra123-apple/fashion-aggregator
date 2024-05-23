class Coupon < ApplicationRecord
   has_many :carts, dependent: :destroy
   validates :code, presence: true, uniqueness: true
   validates :discount_percentage, presence: true

    def apply_discount(original_price)
      if discount_percentage.present? && original_price.present?
        original_price * ((100 - discount_percentage) / 100.0)
      else
        original_price
      end
    end
end