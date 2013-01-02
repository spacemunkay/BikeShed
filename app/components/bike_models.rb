class BikeModels < Netzke::Basepack::Grid
  def configure(c)
    super

    c.model = "BikeModel"
    c.title = "Models"
    c.data_store = {auto_load: false}
    c.scope = lambda { |rel| rel.where(:bike_brand_id => session[:selected_bike_brand_id]);}
    c.strong_default_attrs = {
      :bike_brand_id => session[:selected_bike_brand_id]
    }

    c.columns = [
      { :name => :model }
    ]

    if controller.current_user.user?
      c.prohibit_update = true
      c.prohibit_create = true
      c.prohibit_delete = true
    end
  end

  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply, :add_in_form ] if not controller.current_user.user?
    bbar
  end
end
