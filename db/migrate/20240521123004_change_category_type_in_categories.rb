class ChangeCategoryTypeInCategories < ActiveRecord::Migration[7.1]
  def change
    change_column :categories, :category_type, :string
  end
end
