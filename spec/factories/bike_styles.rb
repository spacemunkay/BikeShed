FactoryGirl.define do
  factory :bike_style do
    style {Faker::Commerce.product_name}
  end
end
