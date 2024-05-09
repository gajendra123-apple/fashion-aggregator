class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image_url, :stock_quantity, :color, :size, :category_id, :subcategory_id
  has_many :reviews
end