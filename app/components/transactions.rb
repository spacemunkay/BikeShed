class Transactions < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Transaction"
    c.strong_default_attrs = { :vendor_id => controller.current_user.id }
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
    [
      :amount,
      :item,
      { :name => :for_bike, :checkboxName => :bike_item, :inputValue => true, :title => "Selling a bike?",
        :xtype => 'fieldset', :checkboxToggle => true, :collapsed => true, :items => [
          {:xtype => 'combo', :no_binding => true, :name => :bike_id, :title => 'Bike', :fieldLabel => 'Bike', :store => bike_store}
        ]
      },
      {
        xtype: 'fieldcontainer',
        fieldLabel: 'Customer Type',
        defaultType: 'radiofield',
        defaults: {
          flex: 1
        },
        layout: 'hbox',
        items: [
          {
            no_binding: true,
            boxLabel: 'Customer',
            name: 'customer_type',
            inputValue: 'Customer',
            id: 'customer_radio'
          },
          {
            no_binding: true,
            boxLabel: 'User',
            name: 'customer_type',
            inputValue: 'User',
            id: 'user_radio'
          }
        ]
      },
      { :name => :for_user, :checkboxName => :customer_type, :inputValue => true, :title => "Customer a User?",
        :xtype => 'fieldset', :collapsible => true, :collapsed => true, :items => [
          {:xtype => 'combo', :no_binding => true, :name => :customer_id, :title => 'User', :fieldLabel => 'User', :store => user_store}
        ]
      },
      { :name => :for_customer, :checkboxName => :customer_type, :inputValue => true, :title => "New Customer?",
        :xtype => 'fieldset', :collapsible => true, :collapsed => true, :items => [
          { :xtype => 'textfield', :no_binding => true, :name => 'customer[first_name]'},
        ]
      }
    ]
  end
end
