class UserStats < Netzke::Base

  def body_content(user)
    bike = user.bike
    completed = user.completed_build_bikes
    #I think it's time to switch to a template
    body = ""
    body += %Q(<div id="user_stats_page">)
    body += %Q(
        <p>Username: #{user.username}</p>
        <p>Total Hours Worked: #{user.total_hours}</p>
        <p>Hours worked in #{Time.now.strftime('%B')}: #{user.current_month_hours}</p>
        <p>Current bike Shop ID: #{bike.shop_id if bike}</p>
        <p>Current bike S/N: #{bike.serial_number if bike}</p>
    )
    unless completed.empty?
      body += %Q(<p>Previously built bikes (#{completed.count}):</p>)
      body += %Q(<ul>)
      completed.each do |b|
        body += %Q(<li>#{b.shop_id}</li>)
      end
      body += %Q(</ul>)
    end
    body += %Q(</div>)
  end

  js_configure do |c|
    c.body_padding = 15
    c.title = "User Stats"
    c.mixin :user_stats
  end

  endpoint :server_update do |params, this|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel
    this[:update] = [body_content(user)]
  end

private
  def user
    controller.current_user
  end

end

