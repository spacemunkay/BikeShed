class BikeStatusesController < AuthenticatedController
  expose(:bike_status)

  expose(:bike_statuses) { BikeStatus.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_status.save
      redirect_to bike_statuses_url
    else
      render :new
    end
  end

  def update
    if bike_status.save
      redirect_to bike_statuses_url
    else
      render :edit
    end
  end

  def destroy
    bike_status.destroy
    redirect_to bike_statuses_url
  end
end
