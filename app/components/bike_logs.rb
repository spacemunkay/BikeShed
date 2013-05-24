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
      { :name => :hours, :getter => lambda { |rec| (rec.end_date - rec.start_date)/3600 }, :sorting_scope => :sort_by_duration},
      :description,
      { :name => :bike_action__action, :text => 'Action'},
      { :name => :created_at, :read_only => true},
      { :name => :updated_at, :read_only => true},
      { :name => :logged_by, :getter => lambda{ |rec|
                                                user = User.find_by_id(rec.logger_id)
                                                user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                              }
      }
    ]
=begin
    #TODO: fix GUI so it actually respects this
    current_bike = Bike.find_by_id(session[:selected_bike_id])
    if can? :manage, current_bike
      puts "\n\n\nCAN MANAGE!\n\n\n"
      c.bbar = default_bbar
    else
      puts "\n\n\nCANNNOT MANAGE!\n\n\n"
      # if you can't update the bike, you can't do anything to the log
      #c.prohibit_update = c.prohibit_create = c.prohibit_delete = true
      c.bbar = [ :search ]
    end
=end
  end

  endpoint :set_read_only do |params, this|
    current_bike = Bike.find_by_id(session[:selected_bike_id])
      puts "\n\n\nREAD!\n\n\n"
    if can? :manage, current_bike
      puts "\n\n\nCAN MANAGE!\n\n\n"
      #calls this.setDisabled()
      this.set_disabled(false)
      #sets the return value of this function
      #this.netzke_set_result(true)
    else
      puts "\n\n\nCANNNOT MANAGE!\n\n\n"
      #sets the return value of this function
      #this.netzke_set_result(true)
      this.set_disabled(true)
    end
  end

  def default_fields_for_forms
    [
      { :name => :start_date},
      { :name => :end_date},
      { :name => :description},
      #had to hack acts_as_loggable/log.rb to get this to work
      { :name => :bike_action__action, :field_label => 'Action'}
    ]
  end


  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply ] #if can? :update, ::ActsAsLoggable::Log
    bbar.concat [ :add_in_form ] #if can? :create, ::ActsAsLoggable::Log
    bbar
  end
end
