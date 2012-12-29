class UserProfileBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :user_logs
  component :user_profiles

  def configure(c)
    super
    c.title = "Profile"
    c.items = [
     { netzke_component: :user_logs, region: :center, split: true},
     { netzke_component: :user_profiles, region: :south, height: 150, split: true }
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false
  end

end
