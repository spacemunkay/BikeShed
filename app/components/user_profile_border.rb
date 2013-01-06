class UserProfileBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :user_logs
  component :user_stats
  component :user_profiles

  def configure(c)
    super
    c.header = false
    c.items = [
     { netzke_component: :user_logs, region: :center, split: true},
     { netzke_component: :user_stats, region: :east, width: 350, split: true},
     { netzke_component: :user_profiles, region: :south, height: 150, split: true }
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

        var store = this.getComponent('user_logs').getStore()
        store.on('load', function (store, records, operation, success){
            console.log("Bitches");
            this.getComponent('user_stats').updateStats();
          }, this);
      }
    JS
  end

end
