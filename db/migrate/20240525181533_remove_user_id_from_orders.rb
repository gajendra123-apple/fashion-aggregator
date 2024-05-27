class RemoveUserIdFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_reference :orders, :user, foreign_key: true
    add_reference :orders, :cart, foreign_key: true
  end
end