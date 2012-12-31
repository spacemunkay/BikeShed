FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password 'password'
    password_confirmation { password }
    first_name 'Michael'
    last_name 'Scott'
    user_role_id 1
    sequence(:bike_id) { |n| n }

    factory :staff do
      first_name 'Staff'
      user_role_id 2
    end

    factory :admin do
      first_name 'Admin'
      user_role_id 3
    end

  end
end
