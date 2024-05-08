class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.decimal :total_amount, precision: 10, scale: 2
      t.text :shipping_address
      t.text :billing_address
      t.string :status
      t.timestamps
    end
  end
end