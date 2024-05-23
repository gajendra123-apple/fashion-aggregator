class ChangePriceColumnTypeInProducts < ActiveRecord::Migration[7.1]
  def change
     change_column :products, :price, :float,  precision: 10, scale: 2
  end
end
