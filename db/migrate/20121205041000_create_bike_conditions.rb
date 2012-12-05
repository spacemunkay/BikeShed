class CreateBikeConditions < ActiveRecord::Migration
  def change
    create_table :bike_conditions do |t|
      t.string "condition"
      t.timestamps
    end
  end
end
