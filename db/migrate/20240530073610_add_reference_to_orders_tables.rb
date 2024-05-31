class AddReferenceToOrdersTables < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :product, foreign_key: true
  end
end