class BikeBrand < ActiveRecord::Base
  attr_accessible :brand

  has_many :bikes
  has_many :bike_models

  default_scope order('brand ASC')

  self.per_page = 15

  def models
    self.bike_models
  end

  def to_s
    self.brand
  end
end
