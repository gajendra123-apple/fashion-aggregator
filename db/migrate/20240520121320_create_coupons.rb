class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.decimal :discount_amount, null: false, precision: 10, scale: 2
      t.boolean :active, default: true
      t.datetime :expiration_date
      t.integer :usage_limit
      t.decimal :minimum_purchase_amount, precision: 10, scale: 2
      t.text :applicable_products
      t.integer :usage_count, default: 0
      t.text :redemption_instructions
      t.timestamps
    end
  end
end