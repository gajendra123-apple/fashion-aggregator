class Address < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["address_type", "city", "country", "created_at", "id", "id_value", "phone_number", "recipient_name", "state", "street_address", "updated_at", "zip_code"]
  end
end
