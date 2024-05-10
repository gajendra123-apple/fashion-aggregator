class ShoppingCart < ApplicationRecord

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date_added", "id", "id_value", "quantity", "updated_at"]
  end
end
