class CreatePromptReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :prompt_reviews do |t|
      t.integer :scoring
      t.string :review
      t.string :comment
      t.references :prompt_manager

      t.timestamps
    end
  end
end
