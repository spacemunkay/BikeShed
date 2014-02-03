class Api::V1::BikesController < Api::V1::BaseController
  CANNOT_MANAGE = "You do not have permission to manage bikes."
  EXPECTED_BIKE = "Expected bike in submitted data"

  before_filter :check_bike_permission

  def create
    if bike = params[:bike]

      b = Bike.new(bike)
      if !b.save
        render json: { errors: b.errors }, status: 422 and return
      else
        render json: { bike: b.as_json }, status: 200 and return
      end

    else
        render json: { errors: ["Expected bike in submitted data" ]}, status: 422 and return
    end
    render json: {}, status: 200 and return
  end

  private
    def check_bike_permission
      if cannot? :manage, Bike
        render json: { errors: [CANNOT_MANAGE]}, status: 403 and return
      end
    end
end
