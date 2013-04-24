class Users < Netzke::Basepack::Grid
  def configure(c)
    super
    c.header = false
    c.model = "User"

    c.columns = [
      :first_name,
      :last_name,
      :nickname,
      :email,
      :bike__shop_id
    ]
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
