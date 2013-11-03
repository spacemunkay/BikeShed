# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bike do
    sequence(:shop_id) {|n| n}
    sequence :serial_number do |n|
      "#{Faker::Code.isbn}-#{n}"
    end
    bike_brand_id { Random.rand(100) }
    model { Faker::Commerce.product_name }
    color { sprintf("%06X", Random.rand(16777215) ) }
    bike_style_id { Random.rand(2) }
    seat_tube_height { Random.rand(25) }
    top_tube_length { Random.rand(25) }
    bike_wheel_size_id { Random.rand(10) }
    value { Random.rand(200) }
    bike_condition_id { Random.rand(2) }
    bike_purpose_id { Random.rand(2) }
  end
end
