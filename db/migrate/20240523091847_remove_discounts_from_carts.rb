class RemoveDiscountsFromCarts < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:carts, :discount)
      remove_column :carts, :discount, :decimal
    end
  end
end