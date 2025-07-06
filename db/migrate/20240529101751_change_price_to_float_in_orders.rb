class ChangePriceToFloatInOrders < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:orders, :price)
      change_column :orders, :price, :float
    else
      puts "🛑 Skipping: 'price' column not found in 'orders' table"
    end
  end
end