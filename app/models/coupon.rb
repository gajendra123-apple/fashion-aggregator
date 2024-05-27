class Coupon < ApplicationRecord
   has_many :carts, dependent: :destroy
   validates :code, presence: true, uniqueness: true
   validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

    def apply_discount(total_price)
      if discount_percentage.present? && total_price.present?
        total_price * ((100 - discount_percentage) / 100.0)
      else
        total_price
      end
    end
end