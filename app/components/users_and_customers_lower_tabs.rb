class UsersAndCustomersLowerTabs < Netzke::Basepack::TabPanel
  component :customers
  component :users

  def configure(c)
    c.prevent_header = true
    c.items = [ :users, :customers ]
    super
  end
end
