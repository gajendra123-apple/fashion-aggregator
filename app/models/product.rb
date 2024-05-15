class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :category
  belongs_to :user, optional: true
  belongs_to :subcategory, class_name: 'Subcategory'
  has_many :reviews
  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items
  enum size: { XS:"XS", S: "S", M: "M", L: "L" , XL: "XL" }

  validates :name, :color, :size, :stock_quantity, :image, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than_or_equal_to: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "image_url", "name", "color", "size", "price", "stock_quantity", "updated_at"]
  end
end 