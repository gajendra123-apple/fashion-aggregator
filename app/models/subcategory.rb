class Subcategory < ApplicationRecord
    belongs_to :category
    has_many :subcategories, dependent: :destroy
end