class UserTransactionsBorder < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence
  component :user_transactions
  component :transaction_logs

  def configure(c)
    super
    c.header = false
    c.title = "Transactions"
    c.items = [
     { netzke_component: :user_transactions, region: :center, height: 300, split: true },
     { netzke_component: :transaction_logs, region: :south, height: 300, split: true }
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
