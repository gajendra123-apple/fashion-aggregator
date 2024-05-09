class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :rating, :review_text
    belongs_to :user
end  