class AddColumnToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :color, :string
    add_column :products, :size, :string
  end
end