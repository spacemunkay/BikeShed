class UserProfiles < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "UserProfile"
    c.data_store = {auto_load: false}
    c.scope = lambda { |rel| puts session.inspect; rel.where(:user_id => session[:selected_user_id]);}
    c.columns = [
      { :name => :bike__serial_number},
      :addrStreet1,
      :addrStreet2,
      :addrCity,
      :addrState,
      :addrZip,
      :phone
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form ]
  end
end
