class BikeModels < Netzke::Basepack::Grid
  def configure(c)
    super

    c.model = "BikeModel"
    c.data_store = {auto_load: false}
    c.scope = lambda { |rel| puts session.inspect; rel.where(:bike_brand_id => session[:selected_bike_brand_id]);}
    #c.strong_default_attrs = lambda { |rel| puts rel.inspect;}
    
    c.columns = [
      :model
    ]
    #c.enable_context_menu = false
    #c.context_menu = false
    #c.enable_edit_in_form = false
    #c.scope = {done: [nil, false]}
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end
end
