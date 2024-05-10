class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "id_value", "product_id", "rating", "review_text", "updated_at", "user_id"]
  end
end