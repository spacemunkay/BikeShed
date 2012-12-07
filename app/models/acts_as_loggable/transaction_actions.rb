class ActsAsLoggable::TransactionActions < ActiveRecord::Base
  attr_accessible :action
  
  belongs_to :bike
end
