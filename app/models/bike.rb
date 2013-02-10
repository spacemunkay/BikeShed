class Bike < ActiveRecord::Base
  acts_as_loggable
  attr_accessible :serial_number, :bike_brand_id, :bike_model_id, :color, :bike_style_id, :seat_tube_height,
    :top_tube_length, :wheel_size, :value, :bike_condition_id, :bike_status_id

  has_many :transactions

  has_one :owner, :class_name => 'User'
  has_one :task_list, :as => :item, :dependent => :destroy
  belongs_to :bike_brand
  belongs_to :bike_model
  belongs_to :bike_style
  belongs_to :bike_condition
  belongs_to :bike_status

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

  after_save :create_task_list

  def brand
    self.bike_brand
  end

  def model
    self.bike_model
  end

  def style
    self.bike_style
  end

  def condition
    self.bike_condition
  end

  def status
    self.bike_status
  end

  def to_s
    "#{brand} - #{model} - #{style}"
  end

  def create_task_list
    TaskList.create( item_id: self.id, item_type: self.class.to_s, name: "Safety Checklist")
  end
end
