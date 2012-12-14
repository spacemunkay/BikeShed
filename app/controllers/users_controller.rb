class UsersController < AuthenticatedController
  expose(:user)
  expose(:users) { User.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if user.save
      redirect_to user
    else
      render :new
    end
  end

  def update
    if user.save
      redirect_to user
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    redirect_to bikes_url
  end
end
