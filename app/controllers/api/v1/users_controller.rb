require 'securerandom'
class Api::V1::UsersController < Api::V1::BaseController
  CANNOT_MANAGE = "You do not have the permission to manager users"
  NOT_FOUND = "User not found"
  NOT_ALLOWED = "Not allowed to reset your own password in this fashion"
  PASS_LENGTH = 8

  def password_reset
    if can? :manage, User
      user = User.find_by_id(params[:user_id])
      render :json => { "errors" => [NOT_FOUND]}, :status => 404 and return if user.nil?
      render :json => { "errors" => [NOT_ALLOWED]}, :status => 403 and return if user.id == current_user.id

      new_pass = SecureRandom.hex[0,PASS_LENGTH]
      user.password = new_pass
      user.save
      render :json => { "password" => new_pass}, :status => 200 and return
    else
      render :json => { "errors" => [CANNOT_MANAGE]}, :status => 403 and return
    end
  end


=begin  Is this here by accident? Commenting out for now (1/30/14)
  def checkout
    #must use @current_user since user may not have signed in
    if !@current_user.checked_in?
      render :json => { "error" => "You were not even checked in."}, :status => 404 and return
    else
      @current_user.checkout
      render :nothing => true, :status => 204 and return
    end
  end
=end
end
