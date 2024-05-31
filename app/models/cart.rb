class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  def add_product(product_id, quantity = 1)
    current_item = cart_items.find_or_initialize_by(product_id: product_id)
    current_item.quantity += quantity
    current_item.save
    recalculate_total_with_coupon
  end
  
  def recalculate_total_with_coupon
    self.total_price = cart_items.includes(:product).sum do |item|
      item.product.price * item.quantity
    end
  end

  def apply_coupon(coupon_code)
    coupon = Coupon.find_by(code: coupon_code)
    return false unless coupon
    self.coupon = coupon
    recalculate_total_with_coupon
    save
  end
  
	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date_added", "id", "id_value", "quantity", "updated_at"]
  end
end