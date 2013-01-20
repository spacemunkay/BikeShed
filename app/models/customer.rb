class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :addrStreet1,
    :addrStreet2, :addrCity, :addrState, :addrZip, :phone, :email

  has_many :transactions, :as => :customer

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  #validates :addrStreet1, :presence => true
  #validates :addrStreet2, :presence => true
  #validates :addrCity, :presence => true
  #validates :addrState, :presence => true
  #validates :addrZip, :presence => true
  #validates :phone, :presence => true
  #validates :email, :presence => true

  def to_s
    "#{first_name} #{last_name}"
  end
end
