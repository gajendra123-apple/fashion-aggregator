class ChangeDiscountPercentageColumnTypeInPromotions < ActiveRecord::Migration[7.1]
  def change
     change_column :promotions, :discount_percentage, :float, precision: 10, scale: 2
  end
end
