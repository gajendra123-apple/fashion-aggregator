class CreateTableSubcategory < ActiveRecord::Migration[7.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.references :category
    end
  end
end
