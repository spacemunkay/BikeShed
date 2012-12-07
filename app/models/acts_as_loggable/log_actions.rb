#this might be good for logging CRUD actions
class ActsAsLoggable::LogActions < ActiveRecord::Base
  attr_accessible :action
  
  belongs_to :log
end
