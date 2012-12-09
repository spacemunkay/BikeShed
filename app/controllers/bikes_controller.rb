class BikesController < AuthenticatedController
  expose(:bike)

  expose(:bikes) { Bike.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike.save
      redirect_to bike
    else
      render :new
    end
  end

  def update
    if bike.save
      redirect_to bike
    else
      render :edit
    end
  end

  def destroy
    bike.destroy
    redirect_to bikes_url
  end
end
