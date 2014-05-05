class Api::V1::TimeEntriesController < Api::V1::BaseController
  EXPECTED_TIME_ENTRY = "Expected time entry in submitted data"
  NOT_FOUND = "Time entry not found"

  def create
    if params[:time_entries] && time_entry = params[:time_entries].first
      time_entry.merge!({ loggable_id: current_user.id,
                          logger_id: current_user.id  })
      bike_id = time_entry[:bike_id].to_i

      @time_entry = TimeEntry.new(time_entry.except(:bike_id))

      if bike_id > 0
        @time_entry.copy_to_bike_history(bike_id)
      end

      if !@time_entry.save
        render json: { errors: @time_entry.errors }, status: 422 and return
      end
    else
      render json: { errors: [EXPECTED_TIME_ENTRY]}, status: 422 and return
    end
  end

  def delete
    if time_entry = TimeEntry.find_by_id(params[:id])
      time_entry.delete
      render nothing: true, status: 204 and return
    else
      render json: { errors: [NOT_FOUND]}, status: 404 and return
    end
  end
end
