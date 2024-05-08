class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.datetime :payment_date
      t.decimal :amount, precision: 10, scale: 2
      t.string :payment_method
      t.timestamps
    end
  end
end