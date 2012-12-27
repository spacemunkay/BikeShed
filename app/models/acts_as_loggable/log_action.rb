#this might be good for logging CRUD actions
class ActsAsLoggable::LogAction < ActiveRecord::Base
  attr_accessible :action
  
  has_many :logs

  def to_s
    self.action
  end
end
