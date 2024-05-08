class CreateWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wishlists do |t|
      t.datetime :date_added

      t.timestamps
    end
  end
end
