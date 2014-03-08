# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bike do
    sequence(:shop_id) {|n| n}
    sequence :serial_number do |n|
      "#{Faker::Code.isbn}-#{n}"
    end
    bike_brand { FactoryGirl.create(:bike_brand) }
    model { Faker::Commerce.product_name }
    color "FFFFFF"
    bike_style { FactoryGirl.create(:bike_style) }
    seat_tube_height 42
    top_tube_length 42
    bike_wheel_size { FactoryGirl.create(:bike_wheel_size) }
    value 200
    bike_condition { FactoryGirl.create(:bike_condition) }
    bike_purpose { FactoryGirl.create(:bike_purpose) }
  end

  factory :seed_bike do
    sequence(:shop_id) {|n| n}
    sequence :serial_number do |n|
      "#{Faker::Code.isbn}-#{n}"
    end
    bike_brand_id { BikeBrand.all.sample.id }
    model { Faker::Commerce.product_name }
    color { sprintf("%06X", Random.rand(16777215) ) }
    bike_style_id { BikeStyle.all.sample.id }
    seat_tube_height { Random.rand(25) }
    top_tube_length { Random.rand(25) }
    bike_wheel_size_id { BikeWheelSize.all.sample.id }
    value { Random.rand(200) }
    bike_condition_id { BikeCondition.all.sample.id }
    bike_purpose_id { BikePurpose.all.sample.id }
  end
end
