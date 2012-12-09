class ActsAsLoggable::BikeActionsController < AuthenticatedController
  expose(:bike_action) do
    if params[:id]
      BikeAction.find(params[:id])
    elsif params[:bike_action]
      BikeAction.new(params[:bike_action])
    else
      puts "WhOOOPS"
      #BikeAction.new(:max_members => 16)
    end
  end

  expose(:bike_actions) { BikeAction.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_action.save
      redirect_to bike_actions_url
    else
      render :new
    end
  end
end
