FactoryGirl.define do
  factory :user_profile do
    user_id 1
    addrStreet1 { Faker::Address.street_address }
    addrStreet2 { Faker::Address.secondary_address }
    addrCity { Faker::Address.city }
    addrState { Faker::Address.state_abbr }
    addrZip { Faker::Address.zip_code }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
