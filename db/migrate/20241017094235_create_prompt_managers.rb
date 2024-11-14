class CreatePromptManagers < ActiveRecord::Migration[7.1]
  def change
    create_table :prompt_managers do |t|
      t.text :context
      t.string :gpt_version
      t.string :question
      t.text :prompt_template
      t.integer :threshold
      t.integer :contact_results
      t.text :answer
      t.string :language
      t.string :country
      # t.datetime "created_at", precision: 6, null: false
      # t.datetime "updated_at", precision: 6, null: false
      t.string :prefix

      t.timestamps
    end
  end
end
