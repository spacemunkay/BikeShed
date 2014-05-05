class PanelController < ApplicationController

  def index
    render :inline => "<%=netzke :app_view, :layout => true %>", :layout => "netzke"
  end

end
