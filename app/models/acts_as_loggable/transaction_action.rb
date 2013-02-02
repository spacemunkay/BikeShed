class ActsAsLoggable::TransactionAction < ActiveRecord::Base
  attr_accessible :action

  has_many :logs
  #belongs_to :bike

  def to_s
    self.action
  end
end
