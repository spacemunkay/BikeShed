class BikeBrand < ActiveRecord::Base
  attr_accessible :brand

  has_many :bikes
  has_many :bike_models

  self.per_page = 15

  def models
    self.bike_models
  end

  def to_s
    self.brand
  end
end
