class Api::V1::BikesController < Api::V1::BaseController
  CANNOT_MANAGE = "You do not have permission to manage bikes."
  EXPECTED_BIKE = "Expected bike in submitted data"
  NOT_FOUND = "The bike could not be found."

  before_filter :check_bike_permission, except: :show

  def create
    if params[:bikes] && bike = params[:bikes].first
      @bike = Bike.new(bike)
      if !@bike.save
        render json: { errors: @bike.errors }, status: 422 and return
      end
    else
        render json: { errors: [EXPECTED_BIKE]}, status: 422 and return
    end
  end

  def show
    @bike = Bike.find_by_id(params[:id])
    if @bike.nil?
      render json: { errors: [NOT_FOUND] }, status: 404 and return
    end
  end

  private
    def check_bike_permission
      if cannot? :manage, Bike
        render json: { errors: [CANNOT_MANAGE]}, status: 403 and return
      end
    end
end
