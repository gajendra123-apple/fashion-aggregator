class Coupon < ApplicationRecord
  
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :expiration_date, :minimum_purchase_amount, :coupon_name, :redemption_instructions, :presence => true
  before_save :create_code, if: :new_record?
  after_initialize :set_default_usage_limit, if: :new_record?


  # def apply_discount(total_price)
  #   if discount_percentage.present? && total_price.present?
  #     total_price * ((100 - discount_percentage) / 100.0)
  #   else
  #     total_price
  #   end
  # end
  def self.ransackable_attributes(auth_object = nil)
    ["active", "coupon_name", "code", "created_at", "discount_percentage", "expiration_date", "id", "id_value", "minimum_purchase_amount", "redemption_instructions", "updated_at", "usage_count", "usage_limit"]
  end

  private

  def create_code
    self.code = SecureRandom.hex(3).upcase
  end

  def set_default_usage_limit
    self.usage_limit = 1
  end
end