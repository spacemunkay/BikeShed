class AppTabPanel < Netzke::Basepack::TabPanel
 component :bikes_border
 component :brands_and_models_border
 component :users_and_profiles_border
 component :logs
 component :bike_log_form

  def configure(c)
    c.active_tab = 3
    c.prevent_header = true
    c.items = [ :bikes_border, :brands_and_models_border, :users_and_profiles_border, :logs, :bike_log_form]
    super
  end
end

