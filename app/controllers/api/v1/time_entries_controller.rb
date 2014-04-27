class Api::V1::TimeEntriesController < Api::V1::BaseController
  EXPECTED_TIME_ENTRY = "Expected time entry in submitted data"

  def create
    if params[:time_entries] && time_entry = params[:time_entries].first
      time_entry.merge!({ loggable_id: current_user.id,
                          logger_id: current_user.id  })
      bike_id = time_entry[:bike_id].to_i

      if bike_id > 0
        time_entry.copy_to_bike_history(bike_id)
      end

      @time_entry = TimeEntry.new(time_entry.except(:bike_id))
      if !@time_entry.save
        render json: { errors: @time_entry.errors }, status: 422 and return
      end
    else
      render json: { errors: [EXPECTED_TIME_ENTRY]}, status: 422 and return
    end
  end
end
