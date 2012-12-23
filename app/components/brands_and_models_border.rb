class BrandsAndModelsBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :bike_brands
  component :bike_models
  def configure(c)
    super
    c.title = "Brands/Models"
    c.items = [
#      { netzke_component: :bike_brands, region: :center, split: true }
     { netzke_component: :bike_brands, region: :center, split: true },
     { netzke_component: :bike_models, region: :east, width: 500, split: true}
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false

# Overriding initComponent
    c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();

        // setting the 'rowclick' event
        var view = this.getComponent('bike_brands').getView();
        view.on('itemclick', function(view, record){
          // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
          this.selectBikeBrand({bike_brand_id: record.get('id')});
          this.getComponent('bike_models').getStore().load();
        }, this);
      }
    JS
  end

  endpoint :select_bike_brand do |params, this|
    # store selected boss id in the session for this component's instance
    session[:selected_bike_brand_id] = params[:bike_brand_id]
    puts "BikeBrandID-----------------------------"
    #puts params[:bike_brand_id]
    puts session.inspect

=begin
    brand = BikeBrand.find_by_id(params[:bike_brand_id])
    bike_models_grid = component_instance(:bike_models)
    bike_models_data = bike_models_grid.get_data

    {
      :bike_models=> {:load_store_data => bike_models_data, :set_title => "Models for #{brand.brand}"},
    }
=end 
  end


  
end
