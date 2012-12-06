class ActsAsLoggable::TransactionActions < ActiveRecord::Base
  set_fixture_class :bike_actions => ActsAsLoggable::TransactionActions
  attr_accessible :action
  
  belongs_to :bike
end
