class BikeCondition < ActiveRecord::Base
  attr_accessible :condition

  belongs_to :bike

  def to_s
    self.condition
  end
end
