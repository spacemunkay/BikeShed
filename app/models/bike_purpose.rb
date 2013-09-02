class BikePurpose < ActiveRecord::Base
  attr_accessible :purpose

  belongs_to :bike

  def to_s
    self.purpose
  end
end
