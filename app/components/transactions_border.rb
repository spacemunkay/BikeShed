class TransactionsBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :transactions
  #users and customers components are required for the transactions form
  component :users_and_customers_accordian

  def configure(c)
    super
    c.header = false
    c.title = "Transactions"
    c.items = [
     { netzke_component: :transactions, region: :center, height: 300, split: true },
     { netzke_component: :users_and_customers_accordian, region: :south, height: 300, split: true }
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
