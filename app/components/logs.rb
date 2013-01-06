class Logs < Netzke::Basepack::Grid

  def configure(c)
    super
    c.header = false
    c.model = "ActsAsLoggable::Log"
    c.columns = [
      :loggable_id,
      :loggable_type,
      :logger_id,
      :logger_type,
      :context,
      :start_date,
      :end_date,
      :description,
      :log_action_id,
      :log_action_type,
      :created_at,
      :updated_at,
      { :name => :s_date, :getter => lambda { |rec| rec.start_date.strftime("%b %d  '%y")}, :width => 75, :sorting_scope => :sort_by_start_date },
      { :name => :s_time, :getter => lambda { |rec| rec.start_date.strftime("%I:%M %p")}, :width => 75 },
      { :name => :hours, :getter => lambda { |rec| (rec.end_date - rec.start_date)/3600 }, :sorting_scope => :sort_by_duration}
    ]
  end
end
