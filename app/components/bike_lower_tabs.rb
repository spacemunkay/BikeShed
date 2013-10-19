class BikeLowerTabs < Netzke::Basepack::TabPanel
  component :bike_logs
  component :tasks
  component :brands_and_models_border

  def configure(c)
    c.prevent_header = true
    c.items = [ :bike_logs, :tasks,
                {netzke_component: :brands_and_models_border, title: "Brands and Models"} ]
    super
  end
end
