class SiteController < ApplicationController

  def index
    @bike = current_user.bike
  end
end
