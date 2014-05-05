FactoryGirl.define do
  factory :task do
    task_list { FactoryGirl.create(:task_list) }
    done false
    task { Faker::Lorem.words(7).join(" ")}
  end
end
