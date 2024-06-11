FactoryBot.define do
    factory :subcategory do
      name { Faker::Name.name }
      association :category
    end
end 