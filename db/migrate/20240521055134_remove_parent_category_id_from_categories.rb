class RemoveParentCategoryIdFromCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :parent_category_id, :integer
  end
end
