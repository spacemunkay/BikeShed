class UserTransactions < Netzke::Basepack::Grid

  def configure(c)
    super

    c.model = "Transaction"
    c.title = "Transactions"
    c.force_fit = true
    c.scope = lambda { |rel| rel.where(:customer_id => controller.current_user.id, :customer_type => 'User');}
    c.data_store = { auto_load: true }
    c.columns = [
      :amount,
      :item,
      { :name => :bike__shop_id},
      { :name => :vendor, :getter => lambda { |rec|
                                              user = rec.vendor
                                              user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                           }
      },
      { :name => :customer, :getter => lambda { |rec|
                                              user = rec.customer
                                              user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                           }
      },
      :created_at
    ]

    c.prohibit_update = true if cannot? :update, Transaction
    c.prohibit_create = true if cannot? :create, Transaction
    c.prohibit_delete = true if cannot? :delete, Transaction
  end

  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply ] if can? :update, Transaction
    bbar.concat [ :add_in_form ] if can? :create, Transaction
    bbar
  end
end
