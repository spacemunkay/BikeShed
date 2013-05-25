FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password 'password'
    password_confirmation { password }
    first_name 'Michael'
    last_name 'Scott'
    sequence(:bike_id) { |n| n }
    association :user_role, factory: :role_user

    factory :staff do
      username "staff"
      first_name 'Staff'
      association :user_role, factory: :role_staff
    end

    factory :admin do
      username "admin"
      first_name 'Admin'
      association :user_role, factory: :role_admin
    end

    factory :bike_admin do
      username "bike_admin"
      first_name 'BikeAdmin'
      association :user_role, factory: :role_bike_admin
    end

  end
end
