class RemoveApplicableProductsFromCoupons < ActiveRecord::Migration[7.1]
  def change
    remove_column :coupons, :applicable_products, :text
  end
end
