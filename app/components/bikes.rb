class Bikes < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Bike"

    c.columns = [
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
      :color,
      { :name => :bike_style__style, :text => 'Style' },
      :seat_tube_height,
      :top_tube_length,
      :wheel_size,
      :value,
      { :name => :bike_condition__condition, :text => 'Condition'},
      { :name => :bike_status__status, :text => 'Status'}
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form ]
  end

  js_configure do |c|
    c.init_component = <<-JS
          function(){
            // calling superclass's initComponent
            this.callParent();

            // setting the 'rowclick' event
            var view = this.getView();
            view.on('itemclick', function(view, record){
            console.log(view);
            console.log(record);
              // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
              this.selectBikeBrand({bike_brand_id: record.get('bike_brand__brand')});
            }, this);
          }
        JS
  end

  endpoint :select_bike_brand do |params, this|
    # store selected boss id in the session for this component's instance
    session[:selected_bike_brand_id] = params[:bike_brand_id]
    puts "BikeID-----------------------------"
    #puts params[:bike_brand_id]
    puts session.inspect
  end
end
