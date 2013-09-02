class BikeModel < ActiveRecord::Base
  attr_accessible :model, :bike_brand_id

  belongs_to :bike_brand

  default_scope order('model ASC')

  self.per_page = 15

  def brand
    self.bike_brand
  end

  def to_s
    self.model
  end
end
