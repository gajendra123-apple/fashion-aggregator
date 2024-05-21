class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy #class_name: "Category", foreign_key: "parent_category", dependent: :destroy
  has_many :products, dependent: :destroy
  enum category_type: { Men:"men", Women: "women", Kids: "kids" }
  validates :name,  presence: true

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end