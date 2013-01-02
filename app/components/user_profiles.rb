class UserProfiles < Netzke::Basepack::Grid
  def configure(c)
    super

    if controller.current_user.user?
      user_profiles_scope = lambda { |rel| rel.where(:user_id => controller.current_user.id);}
      user_profiles_data_store = { auto_load: true }
    else
      user_profiles_scope = lambda { |rel| rel.where(:user_id => session[:selected_user_id]);}
      user_profiles_data_store = { auto_load: false}
    end

    c.model = "UserProfile"
    c.title = "Profile"
    c.data_store = user_profiles_data_store
    c.scope = user_profiles_scope
    c.columns = [
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
