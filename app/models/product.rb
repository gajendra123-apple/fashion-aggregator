require 'open-uri'
class Product < ApplicationRecord
    belongs_to :category
    belongs_to :subcategory, class_name: 'Subcategory'
    has_many :order_items, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "image_url", "name", "color", "size", "price", "stock_quantity", "updated_at"]
  end

  # before_save :grab_image

  # def grab_image
  #   downloaded_image = URI.open("http://www.example.com/image.jpg")
  #   image.attach(io: downloaded_image, filename: "foo.jpg")
  # end
end 