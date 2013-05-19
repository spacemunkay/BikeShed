class AppTabPanel < Netzke::Basepack::TabPanel


  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Sign out #{controller.current_user.email}" if controller.current_user
  end

  action :check_out do |c|
    c.icon = :door_out
    c.text = "CHECK OUT" if controller.current_user
  end

  def configure(c)

    #all users
    #  (had to use hash for borders to get the title to display properly)
    @@app_tab_panel_items = [ :bikes_border,
                              { layout: :fit,
                                wrappedComponent: :brands_and_models_border,
                                title: "Brands/Models"}
                              ]

    #for users
    if controller.current_user.role?(:user)
      # (had to use hash for borders to get the title to display properly)
      @@app_tab_panel_items.concat [{ layout: :fit,
                                      wrappedComponent: :user_profile_border,
                                      title: "Profile"},
                                    { layout: :fit,
                                      wrappedComponent: :user_transactions_border,
                                      title: "Transactions"}
                                    ]
    end
    #for admins
    if controller.current_user.role?(:admin)
      # (had to use hash for borders to get the title to display properly)
      @@app_tab_panel_items.concat [{ layout: :fit,
                                      wrappedComponent: :users_and_profiles_border,
                                      title: "Users/Profiles"},
                                      { layout: :fit,
                                      wrappedComponent: :transactions_border,
                                      title: "Transactions"},
                                      :logs,
                                      :user_roles]
    end

    @@app_tab_panel_items.each do |item|
      if item.kind_of?(Symbol)
        self.class.component item
      elsif item.kind_of?(Hash)
        self.class.component item[:wrappedComponent]
      end
    end

    c.prevent_header = true
    c.tbar = [:sign_out, :check_out]
    c.items = @@app_tab_panel_items
    super
  end

  js_configure do |c|
    #gets js from app_tab_panel/javascripts/sign_out.js
    c.mixin :sign_out
  end
end

