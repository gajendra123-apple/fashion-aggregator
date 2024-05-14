class Payment < ApplicationRecord

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }

	def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "id_value", "payment_date", "payment_method", "updated_at"]
  end
end
