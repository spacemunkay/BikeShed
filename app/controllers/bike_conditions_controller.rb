class BikeConditionsController < AuthenticatedController
  expose(:bike_condition)

  expose(:bike_conditions) { BikeCondition.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_condition.save
      redirect_to bike_conditions_url
    else
      render :new
    end
  end

  def update
    if bike_condition.save
      redirect_to bike_conditions_url
    else
      render :edit
    end
  end

  def destroy
    bike_condition.destroy
    redirect_to bike_conditions_url
  end
end
