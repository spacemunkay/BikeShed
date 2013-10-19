class BikeLogs < Netzke::Basepack::Grid


  def configure(c)
    super

    c.model = "ActsAsLoggable::Log"
    c.title = "Bike History"
    c.data_store = {auto_load: false}
    c.scope = lambda { |rel| rel.where(:loggable_type => 'Bike',:loggable_id => session[:selected_bike_id]);}
    c.strong_default_attrs = {
      :loggable_type => 'Bike',
      :loggable_id => session[:selected_bike_id],
      :log_action_type => 'ActsAsLoggable::BikeAction',
      :logger_type => 'User',
      :logger_id => controller.current_user.id
    }

    c.columns = [
      { :name => :start_date, :format => "g:ia - D, M j - Y", :width => 165, :default_value => Time.now.to_formatted_s(:db)  },
      { :name => :end_date, :hidden => true, :default_value => Time.now.to_formatted_s(:db) },
      :description,
      { :name => :bike_action__action, :text => 'Action', :default_value => ::ActsAsLoggable::BikeAction.first.id},
      { :name => :logged_by, :getter => lambda{ |rec|
                                                user = User.find_by_id(rec.logger_id)
                                                user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                              }
      }
    ]

    @bike_logs = ::ActsAsLoggable::Log.where(:loggable_type => "Bike").all
    c.prohibit_update = true if cannot? :update, @bike_logs
    c.prohibit_create = true if cannot? :create, @bike_logs
    c.prohibit_delete = true if cannot? :delete, @bike_logs
=begin
    #TODO: fix GUI so it actually respects this
    current_bike = Bike.find_by_id(session[:selected_bike_id]) 
    if cannot? :update, current_bike
      # if you can't update the bike, you can't do anything to the log
      c.prohibit_update = c.prohibit_create = c.prohibit_delete = true
    end
=end
  end

  def default_fields_for_forms
    [
      { :name => :start_date},
      { :name => :description},
      #had to hack acts_as_loggable/log.rb to get this to work
      { :name => :bike_action__action, :field_label => 'Action'}
    ]
  end


  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply ] if can? :update, ::ActsAsLoggable::Log
    bbar.concat [ :add_in_form ] if can? :create, ::ActsAsLoggable::Log
    bbar
  end

end
