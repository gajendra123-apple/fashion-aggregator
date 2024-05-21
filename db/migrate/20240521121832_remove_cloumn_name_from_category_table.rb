class RemoveCloumnNameFromCategoryTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :name, :string
  end
end
