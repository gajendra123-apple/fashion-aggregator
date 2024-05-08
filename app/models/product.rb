class Product < ApplicationRecord
  belongs_to :category, optional: :true
  has_one_attached :image
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "image_url", "name", "price", "stock_quantity", "updated_at"]
  end
end   