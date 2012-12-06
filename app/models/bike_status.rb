class BikeStatus < ActiveRecord::Base
  attr_accessible :status

  belongs_to :bike
end
