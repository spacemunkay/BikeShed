class Api::V1::TimeEntriesController < Api::V1::BaseController
  def create
    if params[:time_entries] && time_entry = params[:time_entries].first
      puts time_entry.inspect
      time_entry_defaults = {
        loggable_type: "User",
        loggable_id: current_user.id,
        log_action_type: "ActsAsLoggable::UserAction"}
      time_entry.merge(time_entry_defaults)

      if time_entry[:bike_id] >= 0
        copy_defaults = {
          copy_log: true,
          copy_type: 'Bike',
          copy_id: time_entry[:bike_id],
          copy_action_type: 'ActsAsLoggable::BikeAction',
          copy_action_id: 4
        }
        time_entry.merge( copy_defaults )
      end

      @time_entry = ::ActsAsLoggable::Log.new(time_entry.except(:bike_id))
      if !@time_entry.save
        render json: { errors: @time_entry.errors }, status: 422 and return
      end
    else
      render json: { errors: [EXPECTED_TIME_ENTRY]}, status: 422 and return
    end
  end
end
