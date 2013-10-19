class AlterBikeWheelToId < ActiveRecord::Migration
  def up
    add_column :bikes, :bike_wheel_size_id, :integer

    undetermined_id = BikeWheelSize.find_by_rdin("0")
    Bike.find_each do |bike|
      wheel_size = BikeWheelSize.find_by_rdin(bike['wheel_size'].to_s)

      if wheel_size.nil?
        wheel_size_id = undetermined_id
      else
        wheel_size_id = wheel_size.id
      end
      bike.bike_wheel_size_id = wheel_size_id
      bike.save
    end

    remove_column :bikes, :wheel_size
  end

  def down

    add_column :bikes, :wheel_size, :integer

    Bike.find_each do |bike|
      wheel_size = BikeWheelSize.find_by_id(bike['bike_wheel_size_id'])
      bike.wheel_size = wheel_size.rdin.to_i
      bike.save
    end

    remove_column :bikes, :bike_wheel_size_id

  end
end
