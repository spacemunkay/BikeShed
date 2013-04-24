class User < ActiveRecord::Base
  acts_as_loggable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable #TODO ,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :nickname, :bike_id,
    :user_profiles_attributes

  has_many :transactions
  has_many :user_profiles
  accepts_nested_attributes_for :user_profiles, allow_destroy: false

  has_many :user_role_joins
  has_many :roles, through: :user_role_joins

  belongs_to :bike

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def to_s
    "#{first_name} #{last_name}"
  end

  def full_name
    to_s
  end

  def role?(role)
    if role.kind_of?(String) or role.kind_of?(Symbol)
      role = Role.find_by_role(role.to_s)
    end
    roles.include?(role)
  end

  def total_hours
    ActsAsLoggable::Log.where( :loggable_type => self.class.to_s, :loggable_id => self.id).sum { |l| (l.end_date - l.start_date)/3600 }.round(2)
  end

  def current_month_hours
    #TODO need to prevent users from saving logs across months, force to create a new log if crossing month
    current_month_range = (Time.now.beginning_of_month..Time.now.end_of_month)
    ActsAsLoggable::Log.where( :loggable_type => self.class.to_s, :loggable_id => self.id)
      .where( :start_date => current_month_range)
      .where( :end_date => current_month_range)
      .sum { |l| (l.end_date - l.start_date)/3600 }
      .round(2)
  end
end
