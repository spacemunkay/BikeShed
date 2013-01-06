class AppTabPanel < Netzke::Basepack::TabPanel


  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Sign out #{controller.current_user.email}" if controller.current_user
  end

  def configure(c)

    #all users
    #  (had to use hash for borders to get the title to display properly)
    @@app_tab_panel_items = [ :bikes_border, {layout: :fit, wrappedComponent: :brands_and_models_border, title: "Brands/Models"}]

    #for users
    if controller.current_user.user?
      # (had to use hash for borders to get the title to display properly)
      @@app_tab_panel_items.concat [{ layout: :fit, wrappedComponent: :user_profile_border, title: "Profile"}]
    end
    #for admins
    if controller.current_user.admin?
      # (had to use hash for borders to get the title to display properly)
      @@app_tab_panel_items.concat [{ layout: :fit, wrappedComponent: :users_and_profiles_border, title: "Users/Profiles"}, :logs]
    end

    @@app_tab_panel_items.each do |item|
      if item.kind_of?(Symbol)
        self.class.component item
      elsif item.kind_of?(Hash)
        self.class.component item[:wrappedComponent]
      end
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

