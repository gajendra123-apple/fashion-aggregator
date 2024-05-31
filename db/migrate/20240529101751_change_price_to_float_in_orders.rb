class ChangePriceToFloatInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column :orders, :price, :float
  end
end