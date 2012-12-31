class UserStats < Netzke::Base

  js_configure do |c|
    c.body_padding = 15
    c.title = "User Stats"
    bike = controller.current_user.bike
    c.html = %Q(
      <div id="user_stats_page">
        <p>Total Hours Worked: #{controller.current_user.total_hours}</p>
        <p>Hours worked in #{Time.now.strftime('%B')}: #{controller.current_user.current_month_hours}</p>
        <p>Current bike ID: #{bike.id if bike}</p>
        <p>Current bike S/N: #{bike.serial_number if bike}</p>
      </div>
    )
  end
end

