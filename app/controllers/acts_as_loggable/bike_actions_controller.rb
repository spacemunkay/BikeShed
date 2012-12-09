class ActsAsLoggable::BikeActionsController < AuthenticatedController
  #TODO Fix this so updating works
  expose(:bike_action)
  expose(:bike_actions) { ActsAsLoggable::BikeAction.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_action.save
      redirect_to acts_as_loggable_bike_actions_url
    else
      render :new
    end
  end

  def update
    puts bike_action.inspect
    if bike_action.save
      redirect_to acts_as_loggable_bike_actions_url
    else
      render :edit
    end
  end

  def destroy
    bike_action.destroy
    redirect_to acts_as_loggable_bike_actions_url
  end
end
