class Users < Netzke::Basepack::Grid
  include Netzke::Basepack::ActionColumn

  column :reset do |c|
    c.type = :action
    c.actions = [{name: :reset_password, icon: :lock_break}]
    c.header = ""
    c.width = 20
  end

  def configure(c)
    super
    c.header = false
    c.model = "User"

    c.columns = [
      { :name => :username, :read_only => true },
      :first_name,
      :last_name,
      :email,
      { :id => :bike__shop_id, :name => :bike__shop_id}
    ]

    c.columns << :reset if can? :manage, User
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
