class AddColumnToCoupon < ActiveRecord::Migration[7.1]
  def change
    add_column :coupons, :coupon_name, :string
  end
end
