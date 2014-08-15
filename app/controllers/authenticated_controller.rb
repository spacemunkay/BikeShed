class AuthenticatedController < ApplicationController
  before_filter :authenticate_user!

  before_filter :get_user_bike

  def get_user_bike
  	@bike = current_user.bike
  end

end
