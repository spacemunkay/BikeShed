class BikeStyle < ActiveRecord::Base
  attr_accessible :style

  belongs_to :bike
end
