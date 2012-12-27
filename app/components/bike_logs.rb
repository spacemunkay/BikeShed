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
      { :name => :start_date, :format => "g:ia - D, M j - Y", :width => 165 },
      { :name => :hours, :getter => lambda { |rec| (rec.end_date - rec.start_date)/3600 }, :sorting_scope => :sort_by_duration},
      :description,
      { :name => :bike_action__action},
      { :name => :created_at, :read_only => true},
      { :name => :updated_at, :read_only => true}
    ]

  end

  def default_fields_for_forms
    [
      :start_date,
      { :name => :end_date, :xtype => 'datetime', :value => Time.now.to_s },
      :description,
      { :name => :bike_action__action}
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end
end
