class Customers < Netzke::Basepack::Grid
  def configure(c)
    c.model = "Customer"
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end
end
