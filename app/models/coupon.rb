class Coupon < ApplicationRecord
    has_many :carts
    validates :code, presence: true, uniqueness: true
    validates :discount_amount, presence: true

    def apply_discount(original_price)
        if discount_amount.present?
          original_price * ((100 - discount_percentage) / 100.0)
        elsif discount_amount.present?
          [original_price - discount_amount, 0].max
        else
          original_price
        end
    end
end