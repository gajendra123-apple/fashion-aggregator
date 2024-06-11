FactoryBot.define do
  factory :category do
    category_type { %w[men women kids].sample }
  end
end