class CreateRazorpayOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :razorpay_orders do |t|
      t.string :order_id
      t.float :amount, precision: 10, scale: 2
      t.string :currency
      t.string :receipt
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
