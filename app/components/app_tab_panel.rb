class AppTabPanel < Netzke::Basepack::TabPanel


  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Exit"
  end

  action :check_out do |c|
    c.icon = :door_out
    c.text = "CHECK OUT" if controller.current_user
  end

  action :change_account_info do |c|
    c.icon = :user_edit
    c.text = "Change Email/Password"
  end

  def configure(c)

    #all users
    #  (had to use hash for borders to get the title to display properly)
    @@app_tab_panel_items = [ :bikes_border,
                              { layout: :fit,
                                wrappedComponent: :brands_and_models_border,
                                title: "Brands/Models"}
                              ]

    #for users only
    if not controller.current_user.role?(:admin)
      @@app_tab_panel_items.concat [{ layout: :fit,
                                      wrappedComponent: :user_profile_border,
                                      title: "My Profile"},
                                    { layout: :fit,
                                      wrappedComponent: :user_transactions_border,
                                      title: "My Transactions"}
                                    ]
    end
    #for admins
    if can? :manage, User
      @@app_tab_panel_items.concat [{ layout: :fit,
                                      wrappedComponent: :users_and_profiles_border,
                                      title: "Users/Profiles"}]
    end
    if can? :manage, Transaction
      @@app_tab_panel_items.concat [{ layout: :fit,
                                      wrappedComponent: :transactions_border,
                                      title: "Users/Transactions"}]
    end
    if can? :manage, ::ActsAsLoggable::Log.all
      @@app_tab_panel_items.concat [:logs, :check_ins]
    end
    if can? :manage, Role
      @@app_tab_panel_items.concat [{ layout: :fit,
                                      wrappedComponent: :user_role_joins,
                                      title: "User Roles"},
                                      ]
    end

    @@app_tab_panel_items.each do |item|
      if item.kind_of?(Symbol)
        self.class.component item
      elsif item.kind_of?(Hash)
        self.class.component item[:wrappedComponent]
      end
    end
    c.prevent_header = true
    c.tbar = [:sign_out, :check_out, :change_account_info]
    c.items = @@app_tab_panel_items
    super
  end

  js_configure do |c|
    #gets js from app_tab_panel/javascripts/sign_out.js
    c.mixin :sign_out
  end
end

