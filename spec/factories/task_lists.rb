FactoryGirl.define do
  factory :task_list do
    item_id { FactoryGirl.create(:bike).id }
    item_type "Bike"
    name { Faker::Lorem.words.join(" ")}
  end
end
