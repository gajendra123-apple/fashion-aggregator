class AddTotalPriceToCarts < ActiveRecord::Migration[7.1]
  def change
    change_column :carts, :total_price, :float,  precision: 10, scale: 2
  end
end