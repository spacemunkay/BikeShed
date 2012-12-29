class BikeBrands < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "BikeBrand"
    c.title = "Brands"

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
