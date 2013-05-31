class UserProfile < ActiveRecord::Base
  attr_accessible :user_id, :addrStreet1, :addrStreet2, :addrCity,
    :addrState, :addrZip, :phone

  belongs_to :user
  belongs_to :bike

  #validates :addrStreet1 , :presence => true
  #validates :addrCity , :presence => true
  #validates :addrState , :presence => true
  #validates :addrZip , :presence => true
  #validates :phone, :presence => true

  def to_s
    [addrStreet1, addrStreet2, addrCity, addrState, addrZip, phone].join(" - ")
  end
end
