class BikeStatus < ActiveRecord::Base
  attr_accessible :status

  belongs_to :bike

  def to_s
    self.status
  end
end
