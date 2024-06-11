FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    description { "This is a sample product description." }
    price { 99.99 }
    stock_quantity { 10 }
    color { "Red" }
    size { "M" }
    brand_name { "Sample Brand" }
    association :category
    association :subcategory
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', 'images', 'download.webp'),
        'image/webp'
      )
    end
  end
end