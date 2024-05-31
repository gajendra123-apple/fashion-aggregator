class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :brand_name, :stock_quantity, :color, :size, :category_id, :subcategory_id, :image_url
  has_many :reviews

  def image_url
    if object.image.attached?
      final_image = object.image
      if Rails.env.development? || Rails.env.test? || Rails.env.production?
        Rails.application.routes.url_helpers.rails_blob_path(final_image, only_path: true)
      else
        final_image.service_url.split('?').first
      end
    end
  end
end