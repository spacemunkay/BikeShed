class BikeModel < ActiveRecord::Base
  attr_accessible :name

  has_many :bikes
  belongs_to :bike_brand

  def brand
    self.bike_brand
  end
end
