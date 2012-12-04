FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password 'password'
    password_confirmation { password }
    first_name 'Michael'
    last_name 'Scott'
  end

# factory :team do
#   sequence(:name) { |n| "mash it #{n} times" }
#   association :captain, :factory => :user
# end
end
