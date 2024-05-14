class Promotion < ApplicationRecord
	
  validates :promotion_name, :start_date, :end_date, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "discount_percentage", "end_date", "id", "id_value", "promotion_name", "start_date", "updated_at"]
  end
end
