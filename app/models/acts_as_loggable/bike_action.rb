class ActsAsLoggable::BikeAction < ActiveRecord::Base
  #set_fixture_class :bike_actions => ActsAsLoggable::BikeActions
  attr_accessible :action
  
  belongs_to :bike

  def to_s
    self.action
  end
end
