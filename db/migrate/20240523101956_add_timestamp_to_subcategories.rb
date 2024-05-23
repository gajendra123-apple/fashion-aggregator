class AddTimestampToSubcategories < ActiveRecord::Migration[7.1]
  def up
    # Add columns without NOT NULL constraint
    add_column :subcategories, :created_at, :datetime, precision: 6
    add_column :subcategories, :updated_at, :datetime, precision: 6

    # Update existing records with timestamps
    timestamp = Time.current.strftime('%Y-%m-%d %H:%M:%S')
    execute("UPDATE subcategories SET created_at = '#{timestamp}', updated_at = '#{timestamp}'")

    # Add NOT NULL constraint
    change_column :subcategories, :created_at, :datetime, precision: 6, null: false
    change_column :subcategories, :updated_at, :datetime, precision: 6, null: false
  end

  def down
    # Remove columns and their constraints
    remove_column :subcategories, :created_at
    remove_column :subcategories, :updated_at
  end
end
