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
  end

  def down
    drop_table :bike_wheel_sizes
  end
end
