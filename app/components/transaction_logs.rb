class TransactionLogs < Netzke::Basepack::Grid

  def configure(c)
    super

    c.model = "ActsAsLoggable::Log"
    c.title = "Transaction Payments"
    c.force_fit = true
    c.data_store = {auto_load: false}
    c.scope = lambda { |rel| rel.where(:loggable_type => 'Transaction',:loggable_id => session[:selected_transaction_id]);}
    c.strong_default_attrs = {
      :loggable_type => 'Transaction',
      :loggable_id => session[:selected_transaction_id],
      :log_action_type => 'ActsAsLoggable::TransactionAction',
      :logger_type => 'User',
      :logger_id => controller.current_user.id,
      :start_date => Time.now.to_formatted_s(:db),
      :end_date => Time.now.to_formatted_s(:db)
    }

    c.columns = [
      { :name => :start_date, :format => "g:ia - D, M j - Y", :width => 165, :default_value => Time.now.to_formatted_s(:db), :text => 'Date'  },
      { :name => :description, :text => "Amount"} ,
      { :name => :transaction_action__action, :text => 'Method', :default_value => ::ActsAsLoggable::TransactionAction.first.id},
      { :name => :logged_by, :getter => lambda{ |rec|
          user = User.find_by_id(rec.logger_id)
          user.nil? ? "" : "#{user.first_name} #{user.last_name}"
        },
        :text => "Processed by"
      }
    ]

    @transaction_logs = ::ActsAsLoggable::Log.where(:loggable_type => "Transaction").all
    c.prohibit_update = true if cannot? :update, @transaction_logs
    c.prohibit_create = true if cannot? :create, @transaction_logs
    c.prohibit_delete = true if cannot? :delete, @transaction_logs

  end

  def default_fields_for_forms
    customer = "No Customer Selected"
    item = "No Item Selected"
    trans = Transaction.find_by_id(session[:selected_transaction_id])
    if trans
      customer = trans.customer
      item = trans.item
    end
    [
      { :no_binding => true, :xtype => 'displayfield', :fieldLabel => "Payment from:", :value => "#{customer.to_s}"},
      { :no_binding => true, :xtype => 'displayfield', :fieldLabel => "Payment for:", :value => "#{item.to_s}"},
      { :name => :description, :xtype => 'numberfield', :field_label => 'Amount'},
      #had to hack acts_as_loggable/log.rb to get this to work
      { :name => :transaction_action__action, :field_label => 'Payment Method', :min_chars => 1}
    ]
  end


  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply ] if can? :update, @transaction_logs
    bbar.concat [:add_in_form ] if can? :create, @transaction_logs
    bbar
  end

end
