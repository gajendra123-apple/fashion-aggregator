class RemoveDateFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_column :reviews, :date
  end
end
