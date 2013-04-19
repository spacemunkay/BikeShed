class UserRoles < Netzke::Basepack::Grid

  def configure(c)
    super
    c.model = "UserRole"
    c.title = "User Roles"
    c.columns = [ :role, :created_at, :updated_at, :ends ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

end
