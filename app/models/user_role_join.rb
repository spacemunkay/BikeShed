class UserRoleJoin < ActiveRecord::Base
  set_table_name :user_role_joins
  attr_accessible :role_id, :user_id, :ends

  belongs_to :user
  belongs_to :role

  validate :role_id, presence: true, numericality: true
  validate :user_id, presence: true, numericality: true
  validates_uniqueness_of :user_id, :scope => :role_id

  self.per_page = 15
end
