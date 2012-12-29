class AppTabPanel < Netzke::Basepack::TabPanel

  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Sign out #{controller.current_user.email}" if controller.current_user
  end

  def configure(c)

    #all users
    @@app_tab_panel_items = [ :bikes_border, :brands_and_models_border]

    #for users
    if controller.current_user.user?
      @@app_tab_panel_items.concat [:user_profile_border]
    end
    #for admins
    if controller.current_user.admin?
      @@app_tab_panel_items.concat [:users_and_profiles_border, :logs]
    end

    @@app_tab_panel_items.each do |item|
      self.class.component item
    end

    c.active_tab = 0
    c.prevent_header = true
    c.tbar = [:sign_out]
    c.items = @@app_tab_panel_items
    super
  end

  js_configure do |c|
    c.on_sign_out = <<-JS
      //this will give a 401 error, but made 401 exceptions forward to 'users/sign_in'
      function(){
        Ext.Ajax.request({
           url: '/users/sign_out',
           method: 'DELETE'
        });        
      }
    JS
  end

end

