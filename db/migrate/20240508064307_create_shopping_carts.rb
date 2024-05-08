class CreateShoppingCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_carts do |t|
      t.integer :quantity
      t.datetime :date_added
      t.timestamps
    end
  end
end