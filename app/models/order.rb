class Order < ApplicationRecord
  enum status: { pending: "pending", shipped: "shipped", delivered: "delivered" }
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items, dependent: :destroy
 
  validates :order_date, :shipping_address, :billing_address, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :status, presence: true, inclusion: { in: %w[pending shipped delivered] }

  def create_from_cart(cart)  
    transaction do
      cart.cart_items.each do |cart_item|
        order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
      self.total_price = order_items.sum { |item| item.quantity * item.price }
      self.discount = cart.discount
      self.final_price = total_price - discount
      save!
      cart.cart_items.destroy_all
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["billing_address", "created_at", "id", "id_value", "order_date", "shipping_address", "status", "total_amount", "updated_at"]
  end
end