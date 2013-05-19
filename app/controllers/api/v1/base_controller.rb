class Api::V1::BaseController < ActionController::Base
  respond_to :json

  before_filter :authenticate_user

  private
    def authenticate_user
      if params[:token]
        @current_user = User.find_by_authentication_token(params[:token])
      else
        user = User.find_for_database_authentication( :email => params[:username] )
        @current_user = user if user && user.valid_password?( params[:password] )
      end
      unless @current_user
        render :json => {:error => "Username/Password/Token invalid" }, :status => 403
      end
    end

    def current_user
      @current_user
    end
end

