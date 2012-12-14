class UserLogsController < ActsAsLoggable::LogsController
  before_filter :set_loggable_type

  private

    def set_loggable_type
      @loggable_type = 'User'
    end
end
