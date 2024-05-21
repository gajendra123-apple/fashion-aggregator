class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy #class_name: "Category", foreign_key: "parent_category", dependent: :destroy
  has_many :products, dependent: :destroy
  #   enum category_type: { Men:"men", Women: "women", Kids: "kids" }
  validates :category_type,  presence: true

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "category_type", "updated_at"]
  end
end