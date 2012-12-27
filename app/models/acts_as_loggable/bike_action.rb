class ActsAsLoggable::BikeAction < ActiveRecord::Base
  attr_accessible :action
  has_many :logs

  def to_s
    self.action
  end
end
