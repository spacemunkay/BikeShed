class TransactionsBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :transactions
  component :transaction_logs
  #users and customers components are required for the transactions form
  component :users_and_customers_lower_tabs

  def configure(c)
    super
    c.header = false
    c.title = "Transactions"
    c.items = [
     { netzke_component: :transactions, region: :center, height: 300, split: true },
     { netzke_component: :transaction_logs, region: :east, width: 300, split: true },
     { netzke_component: :users_and_customers_lower_tabs, region: :south, height: 300, split: true }
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false
    c.mixin :init_component
  end

  endpoint :select_transaction do |params, this|
    session[:selected_transaction_id] = params[:transaction_id]
  end

end
