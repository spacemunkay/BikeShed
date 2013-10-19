class BikesBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :bikes
  component :bike_lower_tabs

  def configure(c)
    super
    c.header = false
    c.title = "Bikes"
    c.items = [
     { netzke_component: :bikes, region: :center, split: true },
     { netzke_component: :bike_lower_tabs, region: :south, height: 300, split: true}
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false
    c.mixin :init_component
  end

  endpoint :select_bike do |params, this|
    # store selected boss id in the session for this component's instance
    session[:selected_bike_id] = params[:bike_id]
  end
end
