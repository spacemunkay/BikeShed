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

    c.prohibit_update = true if cannot? :update, BikeModel
    c.prohibit_create = true if cannot? :create, BikeModel
    c.prohibit_delete = true if cannot? :delete, BikeModel 
  end

  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply ] if can? :update, BikeModel
    bbar.concat [ :add_in_form ] if can? :create, BikeModel
    bbar
  end
end
