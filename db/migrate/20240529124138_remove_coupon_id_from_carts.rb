class RemoveCouponIdFromCarts < ActiveRecord::Migration[7.1]
  def change
    remove_column :carts, :coupon_id, :integer
  end
end
