class BikeCondition < ActiveRecord::Base
  attr_accessible :condition

  belongs_to :bike
end
