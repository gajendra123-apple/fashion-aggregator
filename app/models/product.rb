class Product < ApplicationRecord
<<<<<<< Updated upstream
    belongs_to :category
    belongs_to :sub_category
    has_many :order_items, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one_attached :image
    
    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "description", "id", "id_value", "image_url", "name", "price", "stock_quantity", "updated_at"]
    end
end   
=======

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "image_url", "name", "price", "stock_quantity", "updated_at"]
  end
end 
>>>>>>> Stashed changes
