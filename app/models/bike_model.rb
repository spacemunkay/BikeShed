class BikeModel < ActiveRecord::Base
  attr_accessible :model

  has_many :bikes
  belongs_to :bike_brand

  self.per_page = 15

  def brand
    self.bike_brand
  end

  def to_s
    self.model
  end
end
