class BikeBrandsController < AuthenticatedController
  expose(:bike_brand)
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
