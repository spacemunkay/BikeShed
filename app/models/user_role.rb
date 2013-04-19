class UserRole < ActiveRecord::Base
  attr_accessible :role

  belongs_to :user

  self.per_page = 15

  def to_s
    self.role
  end
end
