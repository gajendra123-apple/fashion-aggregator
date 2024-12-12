class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true
  validates :review_text, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "id_value", "product_id", "rating", "review_text", "updated_at", "user_id"]
  end
end