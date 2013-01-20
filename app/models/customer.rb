class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :addrStreet1,
    :addrStreet2, :addrCity, :addrState, :addrZip, :phone, :email

  has_many :transactions

  def to_s
    "#{first_name} #{last_name}"
  end
end
