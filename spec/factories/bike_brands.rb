FactoryGirl.define do
  factory :bike_brand do
    brand {Faker::Commerce.product_name}
  end
end
