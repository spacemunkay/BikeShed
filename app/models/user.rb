class User < ActiveRecord::Base
  acts_as_loggable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable #TODO ,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :nickname, :bike_id,
    :user_profiles_attributes, :username

  has_many :transactions
  has_many :user_profiles
  accepts_nested_attributes_for :user_profiles, allow_destroy: false

  has_many :user_role_joins, :conditions => ["ends IS NULL OR ends > ?", Time.now]
  has_many :roles, through: :user_role_joins

  belongs_to :bike

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def to_s
    "#{first_name} #{last_name}"
  end

  def email_required?
    false
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

### TODO methods below probably belong somewhere else

  def completed_build_bikes
    status_id = BikeStatus.find_by_status("BUILDBIKE").id
    Bike.find_by_sql("
      SELECT * 
      FROM bikes
      INNER JOIN( 
        SELECT *
        FROM transactions
        WHERE customer_id = #{self.id}
      ) AS transactions ON bikes.id = transactions.bike_id
      WHERE bike_status_id = #{status_id}")
  end

  def total_hours
    log_action = ::ActsAsLoggable::UserAction.find_by_action("CHECKIN")
    logs.where("log_action_id != ? AND log_action_type = ?", log_action.id, log_action.class.to_s).sum { |l| (l.end_date - l.start_date)/3600 }.round(2)
  end

  def current_month_hours
    log_action = ::ActsAsLoggable::UserAction.find_by_action("CHECKIN")
    #TODO need to prevent users from saving logs across months, force to create a new log if crossing month
    current_month_range = (Time.now.beginning_of_month..Time.now.end_of_month)
    logs.where("log_action_id != ? AND log_action_type = ?", log_action.id, log_action.class.to_s)
      .where( :start_date => current_month_range)
      .where( :end_date => current_month_range)
      .sum { |l| (l.end_date - l.start_date)/3600 }
      .round(2)
  end

  def checked_in?
    log_action = ::ActsAsLoggable::UserAction.find_by_action("CHECKIN")
    checked = logs.where( log_action_id: log_action.id).
      where("start_date >= ?", Time.zone.now.beginning_of_day).
      where("start_date = end_date")
    !checked.empty?
  end

  def checkin
    log_action = ::ActsAsLoggable::UserAction.find_by_action("CHECKIN")
    time = Time.now
    logs.create( logger_id: self.id,
                 logger_type: self.class.to_s,
                 start_date: time,
                 end_date: time,
                 log_action_id: log_action.id,
                 log_action_type: log_action.class.to_s)
    save
  end

  def checkout
    log_action = ::ActsAsLoggable::UserAction.find_by_action("CHECKIN")
    checked = logs.where( log_action_id: log_action.id).
      where("start_date >= ?", Time.zone.now.beginning_of_day).
      where("start_date = end_date").first
    checked.end_date = Time.now
    checked.save
  end
end
