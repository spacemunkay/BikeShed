class TimeEntry < ActsAsLoggable::Log
  default_scope where( loggable_type: "User",
                       logger_type: "User",
                       log_action_type: "ActsAsLoggable::UserAction")

  def copy_to_bike_history(bike_id)
    self.assign_attributes({
          copy_log: true,
          copy_type: 'Bike',
          copy_id: bike_id,
          copy_action_type: 'ActsAsLoggable::BikeAction',
          copy_action_id: 4
        })
  end
end
