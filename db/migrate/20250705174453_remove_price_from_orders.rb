class RemovePriceFromOrders < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:orders, :price)
      remove_column :orders, :price
      puts "✅ Removed column :price from orders"
    else
      puts "🛑 Skipping removal: 'price' column not found in 'orders'"
    end  end
end
