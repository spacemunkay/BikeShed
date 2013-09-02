class Bikes < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Bike"
    c.data_store.sorters = [{ :property => :shop_id, :direction => :ASC}]

    # columns with :id set, have :min_chars set in init_component
    # See: http://stackoverflow.com/questions/17738962/netzke-grid-filtering
    c.columns = [
      { :name => :shop_id, :text => 'Shop ID'},
      :serial_number,
      { :id => :bike_brand__brand, :name => :bike_brand__brand, :text => 'Brand'},
      { :name => :model, :text => 'Model',
        :scope => lambda { |rel|
                    if session[:selected_bike_brand_id]
                      rel.where(:bike_brand_id => session[:selected_bike_brand_id])
                    else
                      rel.all
                    end
                  }
      },
      #needs to have type :action or else won't work in grid, because... netzke
      { :name => "color", :text => "Frame Color", :type => :action, :editor => { :xtype => "xcolorcombo"}, :renderer => :color_block},
      { :id => :bike_style__style, :name => :bike_style__style, :text => 'Style' },
      { :name => :seat_tube_height, :text => 'Seat Tube (in)'},
      { :name => :top_tube_length, :text => 'Top Tube (in)'},
      { :name => :wheel_size, :text => 'Wheel Size (in)'},
      :value,
      { :id => :bike_condition__condition, :name => :bike_condition__condition, :text => 'Condition'},
      { :id => :bike_purpose__purpose, :name => :bike_purpose__purpose, :text => 'Purpose'},
      { :name => :owner, :getter => lambda { |rec|
                                              user = rec.owner
                                              user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                           }
      }
    ]
    @bike = Bike.all
    c.prohibit_update = true if cannot? :update, @bike
    c.prohibit_create = true if cannot? :create, @bike
    c.prohibit_delete = true if cannot? :delete, @bike
  end
  def default_fields_for_forms
    # :field_label MUST be defined in order for search to work
    [
      { :name => :bike_brand__brand, :field_label => 'Brand' },
      { :name => :model, :field_label => 'Model'},
      { :name => :shop_id, :field_label => 'Shop ID'},
      { :name => :serial_number, :field_label => 'Serial Number'},
      { :name => "color", :xtype => "xcolorcombo"},
      { :name => :bike_style__style, :field_label => 'Style' },
      { :name => :seat_tube_height, :field_label => 'Seat Tube (in)'},
      { :name => :top_tube_length, :field_label => 'Top Tube (in)'},
      { :name => :wheel_size, :field_label => 'Wheel Size (in)'},
      { :name => :value, :field_label => 'Value'},
      { :name => :bike_condition__condition, :field_label => 'Condition'},
      { :name => :bike_purpose__purpose, :field_label => 'Purpose'}
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
