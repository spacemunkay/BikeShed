class UserRoleJoins < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "UserRoleJoin"
    c.header = false
    c.title = "User Roles"
    c.columns = [
      { :name => :user__first_name, :text => "First"},
      { :name => :user__last_name, :text => "Last"},
      { :name => :role__role, :text => "Role"},
      :created_at,
      :updated_at,
      :ends ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

end
