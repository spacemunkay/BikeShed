# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bike do
    sequence(:shop_id) {|n| n}
    sequence :serial_number do |n|
      "S/N# #{n}"
    end
    bike_brand_id 1
    bike_model_id 1
    color "FFFFFF"
    bike_style_id 1
    seat_tube_height 5
    top_tube_length 6
    bike_wheel_size_id 1
    value 100
    bike_condition_id 1
    bike_purpose_id 1
  end
end
