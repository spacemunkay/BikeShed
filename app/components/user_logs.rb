class UserLogs < Netzke::Basepack::Grid
  def configure(c)
    super

    #all users
    user_log_strong_default_attrs = {
      :loggable_type => 'User',
      :log_action_type => 'ActsAsLoggable::UserAction',
      :logger_type => 'User',
      :logger_id => controller.current_user.id,
      :copy_type => 'Bike',
      :copy_action_type => 'ActsAsLoggable::BikeAction',
      :copy_action_id => 4
    }

    #this seems inefficient
    if can? :manage, ::ActsAsLoggable::Log.where(:loggable_type => "User").all
      #admins and staff

      #if selected user nil, then the admin is viewing their own profile
      selected_user = User.find_by_id(session[:selected_user_id])
      selected_user = controller.current_user if selected_user.nil?

      user_log_scope = lambda { |rel| rel.where(:loggable_type => 'User',:loggable_id => selected_user.id );}
      user_log_strong_default_attrs.merge!( { :loggable_id => selected_user.id } )
      user_log_data_store = {auto_load: true }
    else
      #just users
      user_log_scope = lambda { |rel| rel.where(:loggable_type => 'User',:loggable_id => controller.current_user.id)}
      user_log_strong_default_attrs.merge!( { :loggable_id => controller.current_user.id } )
      user_log_data_store = {auto_load: true }
    end

    c.model = "ActsAsLoggable::Log"
    c.title = "User Timesheet"
    c.data_store = user_log_data_store
    c.scope = user_log_scope
    c.strong_default_attrs = user_log_strong_default_attrs

    c.columns = [
      { :name => :start_date, :format => "g:ia - D, M j - Y", :width => 165, :default_value => Time.now.to_formatted_s(:db) },
      { :name => :end_date, :format => "g:ia - D, M j - Y", :default_value => Time.now.to_formatted_s(:db) },
      { :name => :hours, :getter => lambda { |rec| (rec.end_date - rec.start_date)/3600 }, :sorting_scope => :sort_by_duration},
      :description,
      { :id => :user_action__action, :name => :user_action__action, :text => 'Action', :default_value => ::ActsAsLoggable::UserAction.all.first.id },
      { :name => :logged_by, :getter => lambda{ |rec|
                                                user = User.find_by_id(rec.logger_id)
                                                user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                              }
      }
    ]
  end

  # Overriding the defautl add in form
  def preconfigure_record_window(c)
    super
    c.form_config.klass = UserLogsAddItem
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

  js_configure do |c|
    c.mixin :init_component
  end

end