class BikeBrands < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "BikeBrand"

    
=begin
    c.columns = [
      :done,
      :name,
      {name: :notes, flex: 1},
      :priority,
      {name: :due, header: "Due on"}
    ]
=end
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
