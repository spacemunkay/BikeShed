class User < ActiveRecord::Base
  acts_as_loggable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable #TODO ,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :nickname, :role_id

  has_many :user_profiles
  belongs_to :user_role

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  self.per_page = 15

  def to_s
    "#{first_name} #{last_name}"
  end

  def user?
    user_role.to_s == "user"
  end

  def staff?
    user_role.to_s == "staff"
  end

  def admin?
    user_role.to_s == "admin"
  end
end
