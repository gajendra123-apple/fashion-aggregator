class AddDiscountToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :discount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end