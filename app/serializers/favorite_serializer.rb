class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :is_favorite, :products, :user_id, :created_at, :updated_at

  attribute :products do |obj|
    object.product.as_json
  end
end