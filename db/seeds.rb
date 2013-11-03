# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'

#Load defaults from db/seed/fixtures
Dir.glob(File.join(Rails.root, 'db', 'seed', 'fixtures', '**', '*.{yml,csv}')).each do |fixture_file, something|
  ActiveRecord::Fixtures.create_fixtures(File.dirname(fixture_file), File.basename(fixture_file, '.*'))
end

#Load bike brands and models from sql
if BikeBrand.all.empty? and BikeModel.all.empty?
  # Need to use DEFAULT instead of explicit IDs that are used in the sql file,
  # so that the PG table ID sequence is incremented
  #
  # Note the drop(1) which assumes we have a junk PRAGMA line at the top
  load_statements = File.readlines(File.join(Rails.root, 'db', 'seed', 'sql', 'bike_brands_and_models.sql')).drop(1).map do |statement|
    statement.sub(/VALUES\(\d+,/, 'VALUES(DEFAULT,')
  end
  ActiveRecord::Base.connection.execute(load_statements.join)
end

if Rails.env.development?

  #create default users
  if User.all.empty?
    u = FactoryGirl.create(:user)
    FactoryGirl.create(:user_profile, user_id: u.id)
    u = FactoryGirl.create(:staff)
    FactoryGirl.create(:user_profile, user_id: u.id)
    u = FactoryGirl.create(:bike_admin)
    FactoryGirl.create(:user_profile, user_id: u.id)
    u = FactoryGirl.create(:admin)
    FactoryGirl.create(:user_profile, user_id: u.id)
  end

  #create fake bikes
  if Bike.all.empty?
    42.times do |n|
      FactoryGirl.create(:bike)
    end
  end
elsif Rails.env.production?

  unless User.find_by_username('admin')
    #create an admin
    admin = User.create!( :username => 'admin',
                  :first_name => 'admin',
                  :last_name => 'admin',
                  :email=>'admin@example.com',
                  :password=>'password')
    admin.roles << Role.find_by_role('admin')
  end

end
