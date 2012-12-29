class UserRole < ActiveRecord::Base
  attr_accessible :role

  has_many :users

  self.per_page = 15

  def to_s
    self.role
  end
end
