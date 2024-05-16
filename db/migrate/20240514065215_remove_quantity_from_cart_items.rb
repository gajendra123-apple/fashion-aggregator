class RemoveQuantityFromCartItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :quantity, :integer
    remove_column :carts, :date_added, :datetime
  end
end