class BikeStyle < ActiveRecord::Base
  attr_accessible :style

  belongs_to :bike

  def to_s
    self.style
  end
end
