class Bike < ActiveRecord::Base
  acts_as_loggable
  attr_accessible :shop_id, :serial_number, :bike_brand_id, :bike_model_id, :model, :color, :bike_style_id,
    :seat_tube_height, :top_tube_length, :bike_wheel_size_id, :value, :bike_condition_id, :bike_purpose_id, :photo

  has_many :transactions

  has_one :owner, :class_name => 'User'
  has_one :task_list, :as => :item, :dependent => :destroy
  belongs_to :bike_brand
  belongs_to :bike_model
  belongs_to :bike_style
  belongs_to :bike_condition
  belongs_to :bike_purpose
  belongs_to :bike_wheel_size

  has_attached_file :photo, :styles => {:thumb => '100x100>'}

  validates :shop_id, :presence => true, :uniqueness => true, :numericality => { :only_integer => true }
  validates :serial_number, :length => { :minimum => 3 }
  validates :model, :length => { :maximum => 50 }
  validates :bike_brand_id, :presence => true, :numericality => { greater_than: 0, message: "is not a valid brand" }
  #validates :color, :presence => true
  validates :bike_style_id, :presence => true, :numericality => { greater_than: 0, message: "is not a valid style" }
  validates :seat_tube_height, :presence => true, :numericality => true
  validates :bike_wheel_size_id, :presence => true, :numericality => { greater_than: 0, message: "is not a valid wheel size" }
  validates :bike_condition_id, :presence => true, :numericality => { greater_than: 0, message: "is not a valid condition" }
  validates :bike_purpose_id, :presence => true, :numericality => { greater_than: 0, message: "is not a valid purpose" }

  validates_attachment :photo,  :content_type => {:content_type => %w{ image/jpeg image/gif image/png }},
                                :file_name => {:matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]}

  self.per_page = 15

  after_create :create_task_list

  def brand
    self.bike_brand
  end

  def style
    self.bike_style
  end

  def condition
    self.bike_condition
  end

  def purpose
    self.bike_purpose
  end

  def wheel_size
    self.bike_wheel_size
  end

  def to_s
    "#{brand} - #{model} - #{style}"
  end

  def create_task_list
    TaskList.create( item_id: self.id, item_type: self.class.to_s, name: "Safety Checklist")
  end
end
