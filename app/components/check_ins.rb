class CheckIns < Netzke::Basepack::Grid

  def configure(c)
    super
    c.header = false
    c.model = "ActsAsLoggable::Log"
    c.scope = lambda { |rel| rel.where(:log_action_id => ::ActsAsLoggable::UserAction.find_by_action("CHECKIN")).
                                 where("start_date >= ?", Time.zone.now.beginning_of_day);
                     }
    c.columns = [
      { :name => :name, :getter => lambda{ |rec|
                                                user = User.find_by_id(rec.loggable_id)
                                                user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                              }
      },
      { :name => "Status", :getter => lambda{ |rec| rec.start_date == rec.end_date ? "Checked In" : "Checked Out" } },
      :start_date,
      :end_date,
    ]
  end
end
