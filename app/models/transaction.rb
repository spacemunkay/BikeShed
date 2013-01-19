class Transaction < ActiveRecord::Base
  acts_as_loggable
  attr_accessible :vendor_id, :customer_id, :customer_type, :bike_id, :amount, :item

  belongs_to :vendor, :class_name => 'User', :foreign_key => 'vendor_id'
  belongs_to :bike

end
