class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items, dependent: :destroy
  belongs_to :category
  # belongs_to :user, optional: true
  belongs_to :subcategory
  has_many :reviews, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
  enum size: { XS:"XS", S: "S", M: "M", L: "L" , XL: "XL" }

  validates :name, :color, :size, :stock_quantity, :image, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than_or_equal_to: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "image_url", "name", "color", "size", "price", "stock_quantity", "updated_at"]
  end
end 