FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      password { 'Password123!' }
      # password { generate_secure_password }
      # password { Faker::Internet.password(min_length: 8) }
      reset_password_token { Faker::Alphanumeric.alphanumeric(number: 20) } 
      reset_password_sent_at { Time.current }
      created_at { Time.current }
      updated_at { Time.current }
    end

    # def generate_secure_password
    #   password = Faker::Internet.password(min_length: 8)
    #   unless password.match?(/[A-Z]/)
    #     password = password.chars
    #     password[rand(0..(password.length - 1))] = ('A'..'Z').to_a.sample
    #     password = password.join
    #   end
    #   password
    # end
end  