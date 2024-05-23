class Favorite < ApplicationRecord
    belongs_to :product
    belongs_to  :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "is_favorite", "product_id", "updated_at", "user_id"]
  end
end