class Customers < Netzke::Basepack::Grid
  def configure(c)
    c.model = "Customer"
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

  #needed for transactions customer selection
  js_configure do |c|
    c.mixin :init_component
  end

  #needed for transactions customer selection
  endpoint :select_customer do |params, this|
    session[:selected_customer_id] = params[:customer_id]
    session[:selected_customer_type] = params[:customer_type]
  end
end
