class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :is_favorite, :product_id, :user_id, :created_at, :updated_at
end