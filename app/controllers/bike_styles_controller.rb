class BikeStylesController < AuthenticatedController
  expose(:bike_style)

  expose(:bike_styles) { BikeStyle.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_style.save
      redirect_to bike_styles_url
    else
      render :new
    end
  end

  def update
    if bike_style.save
      redirect_to bike_styles_url
    else
      render :edit
    end
  end

  def destroy
    bike_style.destroy
    redirect_to bike_styles_url
  end
end
