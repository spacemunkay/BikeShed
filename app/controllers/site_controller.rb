class SiteController < ApplicationController

  def index
    render :inline => "<%= netzke :app_view, :layout => true %>", :layout => "application"
  end

end
