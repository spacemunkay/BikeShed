class UsersAndCustomersAccordian < Netzke::Basepack::Accordion
  component :customers
  component :users

  def configure(c)
    c.prevent_header = true
    c.items = [ :customers, :users ]
    super
  end
end
