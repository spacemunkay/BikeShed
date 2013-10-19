class BikeBrands < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "BikeBrand"
    c.title = "Brands"
    c.force_fit = true

    c.prohibit_update = true if cannot? :update, BikeBrand
    c.prohibit_create = true if cannot? :create, BikeBrand
    c.prohibit_delete = true if cannot? :delete, BikeBrand 
  end

  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply ] if can? :update, BikeBrand
    bbar.concat [ :add_in_form ] if can? :create, BikeBrand
    bbar
  end
end
