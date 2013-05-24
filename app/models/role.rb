class Role < ActiveRecord::Base
  attr_accessible :role

  has_many :user_role_joins
  has_many :users, through: :user_role_joins
  validates_uniqueness_of :role


  def to_s
    self.role
  end

  def ==(other)
    self.role == other.role
  end
end
