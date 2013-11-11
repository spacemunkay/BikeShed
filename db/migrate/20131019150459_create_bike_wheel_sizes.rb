class CreateBikeWheelSizes < ActiveRecord::Migration
  def up
    create_table(:bike_wheel_sizes) do |t|
      t.integer :twmm
      t.integer :rdmm
      t.string :twin
      t.string :rdin
      t.string :twfr
      t.string :rdfr
      t.string :description
      t.string :tire_common_score
    end

    #create the default undetermined wheel size record
    BikeWheelSize.create( twmm: 0, rdmm: 0, rdin: 0, twin: 0, rdfr: 0, twfr: 0, description: "UNDETERMINED", tire_common_score: 0)
    ActiveRecord::Base.connection.execute(IO.read(File.join(Rails.root, "db", "seed", "sql", "common_wheel_sizes.sql")))
  end

  def down
    drop_table :bike_wheel_sizes
  end
end
