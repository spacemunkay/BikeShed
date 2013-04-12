class Ability
  include CanCan::Ability
  
  def initialize(current_user)
    @current_user = current_user
    self.send(current_user.role.to_sym)
  end

  def admin
    can :manage, :all
  end  

  def staff
    can :manage, :all
  end

  def bike_admin
    can :manage, Bike
    can :manage, ::ActsAsLoggable::Log, :loggable_type => "Bike"
  end

  def user
    can :read, :all
    can :update, Bike, :id => @current_user.bike_id unless @current_user.bike.nil?
    can :manage, ::ActsAsLoggable::Log, { :loggable_type => "Bike", :loggable_id => @current_user.bike_id }
    can :manage, ::ActsAsLoggable::Log, { :loggable_type => "User", :loggable_id => @current_user.id }
  end
end
