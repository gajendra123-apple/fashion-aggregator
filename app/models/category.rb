class Category < ApplicationRecord
<<<<<<< Updated upstream
  has_many :subcategories, class_name: "Category", foreign_key: "parent_category", dependent: :destroy
  belongs_to :category_id, class_name: "Category", optional: true
  has_many :products, dependent: :destroy
  enum category_type: { Men:"men", Women: "women", Kids: "kids" }
	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
=======

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
>>>>>>> Stashed changes
