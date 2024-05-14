class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :rating, :review_text
    belongs_to :user
    
    attribute :user do
      {
        id: object.user.id,
        name: object.user.name,
        email: object.user.email
      }
    end
end
  