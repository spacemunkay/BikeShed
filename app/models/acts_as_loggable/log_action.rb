#this might be good for logging CRUD actions
class ActsAsLoggable::LogAction < ActiveRecord::Base
  attr_accessible :action
  
  belongs_to :log

  def to_s
    self.action
  end
end
