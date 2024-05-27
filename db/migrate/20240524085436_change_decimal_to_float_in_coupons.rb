class ChangeDecimalToFloatInCoupons < ActiveRecord::Migration[7.1]
  def change
    change_column :coupons, :discount_percentage, :float,  precision: 10, scale: 2
  end
end