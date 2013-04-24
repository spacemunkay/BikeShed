class UserRoleJoins < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "UserRoleJoin"
    c.title = "User Roles"
    c.columns = [ :user__first_name, :role__role, :created_at, :updated_at, :ends ]
    #c.columns = [ :user__first_name]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

end
