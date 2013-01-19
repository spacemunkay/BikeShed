class Transactions < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Transaction"
    c.strong_default_attrs = { :vendor_id => controller.current_user.id }
    c.columns = [
      :amount,
      :item,
      { :name => :bike__serial_number},
      { :name => :vendor, :getter => lambda { |rec|
                                              user = rec.vendor
                                              user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                           }
      }
    ]
  end
end
