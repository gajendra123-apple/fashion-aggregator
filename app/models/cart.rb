class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  belongs_to :coupon, optional: true
  
  def add_product(product_id, quantity = 1)
    current_item = cart_items.find_or_initialize_by(product_id: product_id)
    current_item.quantity += quantity
    current_item.save
  end

  def remove_product(product_id)
    current_item = cart_items.find_by(product_id: product_id)
    current_item&.destroy
  end

  # def total_price
  #   cart_items.sum { |item| item.price * item.quantity }
  # end

  # def apply_coupon(coupon_code)
  #   byebug
  #   coupon = Coupon.find_by(code: coupon_code)
  #   if coupon && coupon.active?
  #     self.discount = coupon.discount_amount
  #     save
  #   else
  #     errors.add(:base, "Invalid or expired coupon code")
  #     false
  #   end
  # end
  
  
  def total_price
    cart_items.sum { |item| item.price * item.quantity }
  end

  def apply_coupon(coupon_code)
    coupon = Coupon.find_by(code: coupon_code)
    return false unless coupon
    self.coupon = coupon
    cart_items.each do |item|
      item.price = coupon.apply_discount(item.product.price)
      item.save
    end
    save
  end

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date_added", "id", "id_value", "quantity", "updated_at"]
  end
end