class UpdateCouponsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :coupons, :discount_amount, :decimal
    add_column :coupons, :discount_percentage, :decimal, precision: 5, scale: 2
  end
end