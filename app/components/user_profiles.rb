class UserProfiles < Netzke::Basepack::Grid

  def configure(c)
    super

    if can? :manage, UserProfile
      user_profiles_scope = lambda { |rel| rel.where(:user_id => session[:selected_user_id]);}
      user_profiles_data_store = { auto_load: false}
      user_profile_strong_default_attrs = {
        :user_id => session[:selected_user_id]
      }
    else
      user_profiles_scope = lambda { |rel| rel.where(:user_id => controller.current_user.id);}
      user_profiles_data_store = { auto_load: true }
      user_profile_strong_default_attrs = {
        :user_id => controller.current_user.id
      }
    end

    c.model = "UserProfile"
    c.title = "Profile"
    c.data_store = user_profiles_data_store
    c.scope = user_profiles_scope
    c.strong_default_attrs = user_profile_strong_default_attrs
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
