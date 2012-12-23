class SiteController < ApplicationController

  def index
  render :inline => "<%= netzke :app_view, :layout => true%>", :layout => "application"
=begin
    respond_to do |format|
      format.html
    end
=end
  end

end
