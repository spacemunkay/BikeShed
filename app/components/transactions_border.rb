class TransactionsBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  #users and customers components are required for the transactions form
  component :transactions
  component :users
  component :customers

  def configure(c)
    super
    c.header = false
    c.items = [
     { netzke_component: :transactions, region: :west, width: 300, split: true },
     { netzke_component: :users, region: :center, width: 300, split: true },
     { netzke_component: :customers, region: :east, width: 300, split: true }
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false
    c.mixin :init_component
  end

  endpoint :select_customer do |params, this|
    session[:selected_customer_id] = params[:customer_id]
    session[:selected_customer_type] = params[:customer_type]
  end
  
end
