class ActsAsLoggable::UserActions < ActiveRecord::Base
  set_fixture_class :bike_actions => ActsAsLoggable::UserActions
  attr_accessible :action
  
  belongs_to :bike
end
