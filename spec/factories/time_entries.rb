FactoryGirl.define do
  factory :time_entry do
    loggable_type User.to_s
    logger_type User.to_s
    start_date Time.now
    end_date Time.now
    log_action_id 1
    log_action_type ActsAsLoggable::UserAction.to_s
  end
end
