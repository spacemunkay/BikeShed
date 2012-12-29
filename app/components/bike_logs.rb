class BikeLogs < Netzke::Basepack::Grid


  def configure(c)
    super

    c.model = "ActsAsLoggable::Log"
    c.title = "Bike History"
    c.data_store = {auto_load: false}
    c.scope = lambda { |rel| puts session.inspect; rel.where(:loggable_type => 'Bike',:loggable_id => session[:selected_bike_id]);}
    c.strong_default_attrs = {
      :loggable_type => 'Bike',
      :loggable_id => session[:selected_bike_id],
      :log_action_type => 'ActsAsLoggable::BikeAction'
    }

    c.columns = [
      { :name => :start_date, :format => "g:ia - D, M j - Y", :width => 165, :default_value => Time.now.to_formatted_s(:db)  },
      { :name => :end_date, :hidden => true, :default_value => Time.now.to_formatted_s(:db) },
      { :name => :hours, :getter => lambda { |rec| (rec.end_date - rec.start_date)/3600 }, :sorting_scope => :sort_by_duration},
      :description,
      { :name => :bike_action__action, :text => 'Action'},
      { :name => :created_at, :read_only => true},
      { :name => :updated_at, :read_only => true}
    ]
    
    if controller.current_user.user?
      c.prohibit_update = true
      c.prohibit_create = true
      c.prohibit_delete = true
    end

  end

  def default_fields_for_forms
    [
      { :name => :start_date},
      { :name => :end_date},
      :description,
      { :name => :bike_action__action, :field_label => 'Action'}
    ]
  end

  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply, :add_in_form ] if not controller.current_user.user?
    bbar
  end
end
