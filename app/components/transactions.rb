class Transactions < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Transaction"
    c.strong_default_attrs = {
      :vendor_id => controller.current_user.id,
      :customer_id => session[:selected_customer_id],
      :customer_type => session[:selected_customer_type]
    }
    c.columns = [
      :amount,
      :item,
      { :name => :bike__serial_number},
      { :name => :vendor, :getter => lambda { |rec|
                                              user = rec.vendor
                                              user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                           }
      }
    ]
    
  end

  def default_fields_for_forms
    bike_store = Bike.all.map { |b| [b.id, b.serial_number] }
    user_store = User.all.map { |u| [u.id, u.to_s] }
    customer = nil
    if session[:selected_customer_type] == "User"
      customer = User.find_by_id(session[:selected_customer_id])
    elsif session[:selected_customer_type] == "Customer"
      customer = Customer.find_by_id(session[:selected_customer_id])
    end
    
    customer = "No User Selected" if customer.nil?
    [
      { :no_binding => true, :xtype => 'label', :text => "Creating Transaction for: #{customer.to_s}"},
      :amount,
      :item,
      { :name => :for_bike, :checkboxName => :bike_item, :inputValue => true, :title => "Selling a bike?",
        :xtype => 'fieldset', :checkboxToggle => true, :collapsed => true, :items => [
          {:xtype => 'combo', :no_binding => true, :name => :bike_id, :title => 'Bike', :fieldLabel => 'Bike', :store => bike_store}
        ]
      }
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end
end
