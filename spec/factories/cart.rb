FactoryBot.define do
    factory :cart do
      total_price { Faker::Number.decimal(l_digits: 2) }
      association :user
    end
end 