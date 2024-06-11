FactoryBot.define do
    factory :order do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      # password { Faker::Internet.password(min_length: 8) }
      # password {Password123}
      reset_password_token { Faker::Alphanumeric.alphanumeric(number: 20) } 
      reset_password_sent_at { Time.current }
      created_at { Time.current }
      updated_at { Time.current }
    end
end  