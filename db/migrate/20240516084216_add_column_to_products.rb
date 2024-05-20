class AddColumnToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :brand_name, :string
  end
end
