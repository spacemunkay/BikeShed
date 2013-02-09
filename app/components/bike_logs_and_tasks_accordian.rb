class BikeLogsAndTasksAccordian < Netzke::Basepack::Accordion
  component :bike_logs
  component :tasks

  def configure(c)
    c.prevent_header = true
    c.items = [ :bike_logs, :tasks ]
    super
  end
end
