class BikeModelsController < AuthenticatedController
  expose(:bike_model)
  expose(:bike_models) { BikeModel.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_model.save
      redirect_to bike_models_url
    else
      render :new
    end
  end
end
