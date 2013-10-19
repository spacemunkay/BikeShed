# The User Log Add Item Form
class UserLogsAddItem < Netzke::Basepack::Form
  def configure(c)
    super
    c.model = 'ActsAsLoggable::Log'

    #figure out a better way to do this
    bike_store = Bike.all.map { |b| [b.id, b.shop_id] }
    current_user ||= User.find_by_id(session[:selected_user_id]) || controller.current_user
    bike_id = current_user.bike.nil?  ? nil : current_user.bike.id
    c.items = [
      { :no_binding => true, :xtype => 'displayfield', :fieldLabel => "Log for:", :value => "#{current_user.to_s}"},
      { :id => :user_logs_add_form_start, :name => :start_date},
      { :id => :user_logs_add_form_time, :no_binding => true, :name => :time, :xtype => 'field', :fieldLabel => "Time:", :value => 0 },
      { :id => :user_logs_add_form_units, :xtype => 'combo', :no_binding => true, :name => :units, :fieldLabel => 'Units', :store => ['Mins', 'Hrs'], :value => 'Mins' },
      { :id => :user_logs_add_form_end, :name => :end_date, :hidden => true },
      { :name => :description},
      #had to hack acts_as_loggable/log.rb to get this to work
      { :name => :user_action__action, :field_label => 'Action'},
      { :name => :for_bike, :checkboxName => :copy_log, :inputValue => true, 
        :title => "Copy description to a Bike's History?", :xtype => 'fieldset', :checkboxToggle => true, :collapsed => true, :items => [
          {:xtype => 'combo', :no_binding => true, :name => :copy_id, :title => 'Bike', :fieldLabel => 'Bike', :store => bike_store, :value => bike_id}
        ]
      }
    ]
  end

  js_configure do |c|
    c.mixin :init_component
  end
end