class ActsAsLoggable::UserActions < ActiveRecord::Base
  attr_accessible :action
  
  belongs_to :bike
end
