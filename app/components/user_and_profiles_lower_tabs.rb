class UserAndProfilesLowerTabs < Netzke::Basepack::TabPanel
  component :user_profiles
  component :user_logs
  component :user_stats

  def configure(c)
    c.prevent_header = true
    c.items = [ :user_logs,
      { netzke_component: :user_profiles, title: "User Profiles" },
      { netzke_component: :user_stats, title: "User Stats" }]
    super
  end
end
