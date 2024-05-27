class RemoveDiscountsFromCarts < ActiveRecord::Migration[7.1]
  def change
    remove_column :carts, :discount, :decimal
  end
end