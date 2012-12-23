class Users < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "User"

    c.columns = [
      :first_name,
      :last_name,
      :nickname,
      :email
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form ]
  end
end
