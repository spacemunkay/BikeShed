class Bike < ActiveRecord::Base
  attr_accessible :serial_number, :bike_brand_id, :bike_model_id, :color, :bike_style_id, :seat_tube_height,
    :top_tube_length, :wheel_size, :value, :bike_condition_id, :bike_status_id

  has_one :owner, :class_name => 'User'
  has_one :brand, :class_name => 'BikeBrand'
  has_one :model, :class_name => 'BikeModel'
  has_one :style, :class_name => 'BikeStyle'
  has_one :condition, :class_name => 'BikeCondition'
  has_one :status, :class_name => 'BikeStatus'

  validates :serial_number, :uniqueness => true, :length => { :minimum => 3 }
  validates :bike_brand_id, :presence => true
  validates :bike_model_id, :presence => true
  validates :color, :presence => true
  validates :bike_style_id, :presence => true
  validates :seat_tube_height, :presence => true
  validates :top_tube_length, :presence => true
  validates :wheel_size, :presence => true
  #validates :value, :presence => true
  validates :bike_condition_id, :presence => true
  validates :bike_status_id, :presence => true

  self.per_page = 15

  def to_s
    "#{brand} - #{model} - #{style}"
  end
end
