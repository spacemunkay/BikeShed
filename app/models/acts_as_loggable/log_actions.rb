#this might be good for logging CRUD actions
class ActsAsLoggable::LogActions < ActiveRecord::Base
  set_fixture_class :log_actions => ActsAsLoggable::LogActions
  attr_accessible :action
  
  belongs_to :log
end
