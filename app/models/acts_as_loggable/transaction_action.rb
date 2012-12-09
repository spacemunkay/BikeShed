class ActsAsLoggable::TransactionAction < ActiveRecord::Base
  attr_accessible :action
  
  belongs_to :bike

  def to_s
    self.action
  end
end
