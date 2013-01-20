class Transaction < ActiveRecord::Base
  acts_as_loggable

  attr_accessible :vendor_id, :customer_id, :customer_type, :bike_id, :amount, :item,
    :customer_attributes

  belongs_to :vendor, :class_name => 'User', :foreign_key => 'vendor_id'
  belongs_to :bike
  belongs_to :customer

  accepts_nested_attributes_for :customer, allow_destroy: false

  before_save :check_customer_type

  def check_customer_type
    puts "_________------------_________------------_________------------"
    puts self.inspect
    puts "_________------------_________------------_________------------"
  end

  def to_s
    "#{amount} #{item} #{bike_id}"
  end
end
