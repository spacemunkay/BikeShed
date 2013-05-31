FactoryGirl.define do
  factory :role do
    factory :role_staff do
      role 'staff'
    end

    factory :role_admin do
      role 'admin'
    end

    factory :role_bike_admin do
      role 'bike_admin'
    end

    factory :role_user do
      role 'user'
    end
  end
end
