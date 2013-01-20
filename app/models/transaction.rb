class Transaction < ActiveRecord::Base
  acts_as_loggable

  attr_accessible :vendor_id, :customer_id, :customer_type, :bike_id, :amount, :item

  belongs_to :vendor, :class_name => 'User', :foreign_key => 'vendor_id'
  belongs_to :bike
  belongs_to :customer

  validates :vendor_id, :presence => true
  validates :customer_id, :presence => { :message => "Choose a User or Customer"}
  validates :customer_type, :presence => { :message => "Choose a User or Customer"}
  validates :amount, :presence => true
  validates :item, :presence => true

  def to_s
    "#{amount} #{item} #{bike_id}"
  end
end
