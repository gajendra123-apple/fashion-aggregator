class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.string :promotion_name
      t.text :description
      t.decimal :discount_percentage, precision: 5, scale: 2
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end