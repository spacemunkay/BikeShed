class ActsAsLoggable::TransactionActionsController < AuthenticatedController
  #TODO Fix this so updating works
  expose(:transaction_action)
  expose(:transaction_actions) { ActsAsLoggable::TransactionAction.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if transaction_action.save
      redirect_to acts_as_loggable_transaction_actions_url
    else
      render :new
    end
  end

  def update
    if transaction_action.save
      redirect_to acts_as_loggable_transaction_actions_url
    else
      render :edit
    end
  end

  def destroy
    transaction_action.destroy
    redirect_to acts_as_loggable_transaction_actions_url
  end
end
