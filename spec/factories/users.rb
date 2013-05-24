FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password 'password'
    password_confirmation { password }
    first_name 'Michael'
    last_name 'Scott'
    sequence(:bike_id) { |n| n }
    after_build do |r|
      r.roles << (Role.find_by_role("user") || FactoryGirl.create(:role_user))
    end

    factory :staff do
      first_name 'Staff'
      after_build do |r|
        r.roles << (Role.find_by_role("staff") || FactoryGirl.create(:role_staff))
      end
    end

    factory :admin do
      first_name 'Admin'
      after_build do |r|
        r.roles << (Role.find_by_role("admin") || FactoryGirl.create(:role_admin))
      end
    end

    factory :bike_admin do
      first_name 'BikeAdmin'
      after_build do |r|
        r.roles << (Role.find_by_role("bike_admin") || FactoryGirl.create(:role_bike_admin))
      end
    end

  end
end
