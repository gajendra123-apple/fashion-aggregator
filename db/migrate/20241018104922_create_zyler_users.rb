class CreateZylerUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :zyler_users do |t|
      t.string :user_name
      t.string :full_name
      t.string :password
      t.string :user_id
      t.string :firstName
      t.string :lastName
      t.integer :demoUserId
      t.text :measurements
      t.string :partner
      t.boolean :partner_terms_confirmed  
      t.boolean :privacy_policy_confirmed
      t.boolean :email_confirmed       
      t.boolean :onboarding_complete   
      t.string :origin                
      t.string :email                  
      t.json :sliders                 
      t.string :token_id               
      t.string :token_code             
      t.datetime :token_create_time    
      t.json :roles                   
      t.json :settings                
      t.json :user_brands 
      t.references :account, null: false

      t.timestamps
    end
  end
end
