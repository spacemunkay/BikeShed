class CreateBikeConditions < ActiveRecord::Migration
  def change
    create_table :bike_conditions do |t|
      t.string "condition", :null => false
      t.timestamps
    end
  end
end
