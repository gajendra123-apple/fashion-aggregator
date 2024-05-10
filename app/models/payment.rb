class Payment < ApplicationRecord

	def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "id_value", "payment_date", "payment_method", "updated_at"]
  end
end
