class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.decimal :rating
      t.text :review_text
      t.datetime :date
      t.timestamps
    end
  end
end
