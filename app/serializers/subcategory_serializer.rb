class SubcategorySerializer < ActiveModel::Serializer
    attributes :id, :name, :category_id
end