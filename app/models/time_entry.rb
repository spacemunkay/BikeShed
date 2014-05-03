class TimeEntry < ActsAsLoggable::Log
  default_scope where( loggable_type: "User",
                       logger_type: "User",
                       log_action_type: "ActsAsLoggable::UserAction").where("log_action_id != 4").order("start_date DESC")

  def copy_to_bike_history(bike_id)
    self.assign_attributes({
          copy_log: true,
          copy_type: 'Bike',
          copy_id: bike_id,
          copy_action_type: 'ActsAsLoggable::BikeAction',
          copy_action_id: 4
        })
  end

  def duration
    end_date - start_date
  end

  def duration_in_hours
    (duration / 1.hour).round(2)
  end
end
