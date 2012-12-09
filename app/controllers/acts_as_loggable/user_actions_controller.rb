class ActsAsLoggable::UserActionsController < AuthenticatedController
  #TODO Fix this so updating works
  expose(:user_action)
  expose(:user_actions) { ActsAsLoggable::UserAction.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if user_action.save
      redirect_to acts_as_loggable_user_actions_url
    else
      render :new
    end
  end

  def update
    puts user_action.inspect
    if user_action.save
      redirect_to acts_as_loggable_user_actions_url
    else
      render :edit
    end
  end

  def destroy
    user_action.destroy
    redirect_to acts_as_loggable_user_actions_url
  end
end
