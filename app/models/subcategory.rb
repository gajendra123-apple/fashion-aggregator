class Subcategory < ApplicationRecord
    self.table_name = :subcategories
    def self.ransackable_attributes(auth_object = nil)
        ["category_id", "id", "id_value", "name"]
    end
    belongs_to :category
    has_many :products, dependent: :destroy
end 