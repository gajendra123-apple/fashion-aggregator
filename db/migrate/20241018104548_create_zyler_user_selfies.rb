class CreateZylerUserSelfies < ActiveRecord::Migration[7.1]
  def change
    create_table :zyler_user_selfies do |t|
           t.string :selfie_id
      t.references :zyler_user, null: false
      t.bigint :user_id, null: false  
      t.float :head_placement_x  
      t.float :head_placement_y 
      t.float :head_scale  
      t.boolean :color_correction 
      t.json :warnings  

      t.timestamps
    end
  end
end
