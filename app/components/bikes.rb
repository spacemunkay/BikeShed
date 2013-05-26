class Bikes < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Bike"

    c.columns = [
      { :name => :shop_id, :text => 'Shop ID'},
      :serial_number,
      { :name => :bike_brand__brand, :text => 'Brand' },
      { :name => :bike_model__model, :text => 'Model',
        :scope => lambda { |rel|
                    if session[:selected_bike_brand_id]
                      rel.where(:bike_brand_id => session[:selected_bike_brand_id])
                    else
                      rel.all
                    end
                  }
      },
      #needs to have type :action or else won't work in grid, because... netzke
      { :name => "color", :type => :action, :editor => { :xtype => "xcolorcombo"}},
      #{ :name => :color },
      { :name => :bike_style__style, :text => 'Style' },
      { :name => :seat_tube_height, :text => 'Seat Tube (in)'},
      { :name => :top_tube_length, :text => 'Top Tube (in)'},
      { :name => :wheel_size, :text => 'Wheel Size (in)'},
      :value,
      { :name => :bike_condition__condition, :text => 'Condition'},
      { :name => :bike_status__status, :text => 'Status'},
      { :name => :owner, :getter => lambda { |rec|
                                              user = rec.owner
                                              user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                           }
      }
    ]
  end

  def default_fields_for_forms
    [
      { :name => :shop_id, :field_label => 'Shop ID'},
      :serial_number,
      { :name => :bike_brand__brand, :field_label => 'Brand' },
      { :name => :bike_model__model, :field_label => 'Model'},
      { :name => "color", :xtype => "xcolorcombo"},
      { :name => :bike_style__style, :field_label => 'Style' },
      { :name => :seat_tube_height, :field_label => 'Seat Tube (in)'},
      { :name => :top_tube_length, :field_label => 'Top Tube (in)'},
      { :name => :wheel_size, :field_label => 'Wheel Size (in)'},
      :value,
      { :name => :bike_condition__condition, :field_label => 'Condition'},
      { :name => :bike_status__status, :field_label => 'Status'}
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

  js_configure do |c|
    c.mixin :init_component
  end

  endpoint :select_bike_brand do |params, this|
    # store selected boss id in the session for this component's instance
    session[:selected_bike_brand_id] = params[:bike_brand_id]
  end
end
