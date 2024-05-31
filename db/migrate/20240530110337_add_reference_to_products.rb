class AddReferenceToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :order, foreign_key: true
  end
end