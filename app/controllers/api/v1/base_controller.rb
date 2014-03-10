class Api::V1::BaseController < ActionController::Base
  respond_to :json

  before_filter :authenticate_user

  private
    def authenticate_user
      if params[:username]
        user = User.find_for_database_authentication( :username => params[:username] )
        @current_user = user if user && user.valid_password?( params[:password] )

        if @current_user.nil?
          msg = "Username/Password/Token invalid"
          render :json => {:error => msg }, :status => 401 and return
        end
      else
        authenticate_user!
        @current_user = current_user
      end
    end
end

