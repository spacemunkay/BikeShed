class BikesController < AuthenticatedController

  def new
    @bike = Bike.new bike_purpose_id: 1
    @brands = BikeBrand.all.map{ |b| [b.brand, b.id] }
    @brands.unshift( ["Select a brand", -1] )
    @wheel_sizes = BikeWheelSize.all.map{ |w| [w.display_string, w.id] }
    @wheel_sizes.unshift( ["Select a wheel size", -1] )
  end

  def show
    @bike = Bike.find_by_id(params[:id])
    @task_list = @bike.task_list
    @show_add_bike = true if params[:add_bike]
  end

end
