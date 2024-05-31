class ChangePriceToFloatInOrdersTable < ActiveRecord::Migration[7.1]
  def change
    change_column :orders, :total_amount, :float
  end
end