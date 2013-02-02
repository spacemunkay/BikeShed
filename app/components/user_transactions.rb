class UserTransactions < Netzke::Basepack::Grid

  def configure(c)
    super

    c.model = "Transaction"
    c.title = "Transactions"
    c.scope = lambda { |rel| rel.where(:customer_id => controller.current_user.id, :customer_type => 'User');}
    c.data_store = { auto_load: true }
    c.columns = [
      :amount,
      :item,
      { :name => :bike__serial_number},
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

    if controller.current_user.user?
      c.prohibit_update = true
      c.prohibit_create = true
      c.prohibit_delete = true
    end
  end

  #override with nil to remove actions
  def default_bbar
    bbar = [ :search ]
    bbar.concat [ :apply, :add_in_form ] if not controller.current_user.user?
    bbar
  end
end
