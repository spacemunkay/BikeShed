FactoryGirl.define do
  factory :user_profile do
    user_id 1
    addrStreet1 "Charles Street"
    addrStreet2 "Apt #42"
    addrCity "Baltimore"
    addrState "MD"
    addrZip "21231"
    phone "(410)8675309"
  end
end
