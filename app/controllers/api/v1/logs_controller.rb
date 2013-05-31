class Api::V1::LogsController < Api::V1::BaseController

  def checkin
    #must use @current_user since user may not have signed in
    if @current_user.checked_in?
      render :json => { "error" => "You are already checked in."}, :status => 404 and return
    else
      @current_user.checkin
      render :nothing => true, :status => 204 and return
    end
  end

  def checkout
    #must use @current_user since user may not have signed in
    if !@current_user.checked_in?
      render :json => { "error" => "You were not even checked in."}, :status => 404 and return
    else
      @current_user.checkout
      render :nothing => true, :status => 204 and return
    end
  end
end
