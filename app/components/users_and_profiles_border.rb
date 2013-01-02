class UsersAndProfilesBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :users
  component :user_profiles
  component :user_logs

  def configure(c)
    super
    c.title = "Users/Profiles"
    c.items = [
     { netzke_component: :users, region: :center, width: 300, split: true },
     { netzke_component: :user_profiles, region: :south, height: 150, split: true},
     { netzke_component: :user_logs, region: :east, split: true}
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false

    # Overriding initComponent
    c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
        this.getComponent('user_stats').updateStats();

        // setting the 'rowclick' event
        var view = this.getComponent('users').getView();
        view.on('itemclick', function(view, record){
          // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
          this.selectUser({user_id: record.get('id')});
          this.getComponent('user_profiles').getStore().load();
          this.getComponent('user_logs').getStore().load();
        }, this);
      }
    JS
  end

  endpoint :select_user do |params, this|
    # store selected boss id in the session for this component's instance
    session[:selected_user_id] = params[:user_id]
  end
  
end
