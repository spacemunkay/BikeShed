# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'

Dir.glob(File.join(Rails.root, 'test', 'fixtures', '**/*.{yml,csv}')).each do |fixture_file, something|
  puts fixture_file
  puts File.dirname(fixture_file)
  ActiveRecord::Fixtures.create_fixtures(File.dirname(fixture_file), File.basename(fixture_file, '.*'))
end

if Rails.env.development?
  user = FactoryGirl.build(:user)
  FactoryGirl.create(:user) if not User.find_by_email(user.email)
end
