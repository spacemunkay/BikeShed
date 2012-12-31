class UserLogs < Netzke::Basepack::Grid

  def configure(c)
    super

    #all users
    user_log_strong_default_attrs = {
      :loggable_type => 'User',
      :log_action_type => 'ActsAsLoggable::UserAction',
      :copy_type => 'Bike',
      :copy_action_type => 'ActsAsLoggable::BikeAction',
      :copy_action_id => 3
    }

    #just users
    if controller.current_user.user?
      user_log_scope = lambda { |rel| rel.where(:loggable_type => 'User',:loggable_id => controller.current_user.id)}
      user_log_strong_default_attrs.merge!( { :loggable_id => controller.current_user.id } )
      user_log_data_store = {auto_load: true }
    #admins and staff
    else
      user_log_scope = lambda { |rel| puts session.inspect; rel.where(:loggable_type => 'User',:loggable_id => session[:selected_user_id]);}
      user_log_strong_default_attrs.merge!( { :loggable_id => session[:selected_user_id] } )
      user_log_data_store = {auto_load: true }
    end

    c.model = "ActsAsLoggable::Log"
    c.title = "User History"
    c.data_store = user_log_data_store
    c.scope = user_log_scope
    puts "user_log_strong_default_attrs"
    puts user_log_strong_default_attrs.inspect
    c.strong_default_attrs = user_log_strong_default_attrs
    c.columns = [
      { :name => :start_date, :format => "g:ia - D, M j - Y", :width => 165, :default_value => Time.now.to_formatted_s(:db) },
      { :name => :end_date, :hidden => true, :default_value => Time.now.to_formatted_s(:db) },
      { :name => :hours, :getter => lambda { |rec| (rec.end_date - rec.start_date)/3600 }, :sorting_scope => :sort_by_duration},
      :description,
      { :name => :user_action__action, :text => 'Action' },
      :created_at,
      :updated_at
    ]
  end

  def default_fields_for_forms
    #figure out a better way to do this
    bike_store = Bike.all.map { |b| [b.id, b.serial_number] }
    current_user ||= User.find_by_id(session[:selected_user_id]) || controller.current_user
    bike_id = current_user.bike.nil?  ? nil : current_user.bike.id
    puts "YOOOOO BIKE: #{bike_id}"
    [
      { :name => :start_date},
      { :name => :end_date},
      { :name => :description},
      { :name => :user_action__action, :field_label => 'Action'},
      { :name => :for_bike, :title => "Copy description to a Bike's History?", :xtype => 'fieldset', :collapsible => true, :collapsed => true, :items => [
          {:xtype => 'checkbox', :name => :copy_log, :inputValue => true, :read_only => false},
          {:xtype => 'combo', :name => :copy_id, :fieldLabel => 'Bike', :store => bike_store, :value => bike_id}
        ]
      }
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

end
