class AddUserToShoppingcart < ActiveRecord::Migration[7.1]
  def change
    add_reference :shopping_carts, :user, foreign_key: true
  end
end
