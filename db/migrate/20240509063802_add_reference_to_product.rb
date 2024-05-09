class AddReferenceToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :subcategory, foreign_key: true
  end
end
