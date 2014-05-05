class TimeEntriesController < AuthenticatedController

  def new
    @bikes = Bike.all.map{ |b| [b.to_s , b.id] }
    if bike = current_user.bike
      @bikes.unshift( [bike.to_s, bike.id] )
    end
    @bikes.unshift( ["Non-bike work", -1] )
  end

  def index
    @user_time_entries = TimeEntry.where(loggable_id: current_user.id)
    @credits_available = current_user.total_credits
    @hours_worked = current_user.total_hours
  end
end
