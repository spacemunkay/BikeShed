class BikeBrand < ActiveRecord::Base
  attr_accessible :name

  has_many :bikes
  has_many :bike_models

  self.per_page = 15

  def models
    self.bike_models
  end
end
