class AppTabPanel < Netzke::Basepack::TabPanel
 component :bikes
 component :brands_and_models_border
 component :users_and_profiles_border

  def configure(c)
    c.active_tab = 0
    c.prevent_header = true
    c.items = [ :bikes, :brands_and_models_border, :users_and_profiles_border]
    super
  end
end

