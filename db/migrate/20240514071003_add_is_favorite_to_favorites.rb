class AddIsFavoriteToFavorites < ActiveRecord::Migration[7.1]
  def change
   add_column :favorites, :is_favorite, :boolean, default: false  
  end
end
