require 'securerandom'
class Api::V1::UsersController < Api::V1::BaseController

  def password_reset
    if can? :manage, User
      user = User.find_by_id(params[:user_id])
      render :json => { "error" => "User not found"}, :status => 404 and return if user.nil?
      render :json => { "error" => "Not allowed to reset your own password in this fashion."}, :status => 403 and return if user.id == current_user.id

      new_pass = SecureRandom.hex[0,8]
      user.password = new_pass
      user.save
      render :json => { "password" => new_pass}, :status => 200 and return
    else
      render :json => { "error" => "You do not have the permission"}, :status => 403 and return
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
