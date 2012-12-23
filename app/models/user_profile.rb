class UserProfile < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :bike_id, :addrStreet1, :addrStreet2, :addrCity,
    :addrState, :addrZip, :phone
  
  belongs_to :user
  belongs_to :bike

  validates :addrStreet1, :presence => true
  validates :addrCity, :presence => true
  validates :addrState, :presence => true
  validates :addrZip, :presence => true
  validates :phone, :presence => true

  self.per_page = 15

  def to_s
    [addrStreet1, addrStreet2, addrCity, addrState, addrZip, phone].join(" - ")
  end
end
