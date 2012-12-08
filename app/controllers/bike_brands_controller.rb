class BikeBrandsController < AuthenticatedController
  expose(:bike_brand) do
    if params[:id]
      BikeBrand.find(params[:id])
    elsif params[:bike_brand]
      BikeBrand.new(params[:bike_brand])
    else
      BikeBrand.new
    end
  end

  expose(:bike_brands) { BikeBrand.order('id').paginate(:page => params[:page]) }

  def index
  end

  def show
  end

  def new
  end

  def create
    if bike_brand.save
      redirect_to bike_brands_url
    else
      render :new
    end
  end
end
