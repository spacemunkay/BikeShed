class CreateBike < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string   "serial_number"
      t.integer  "bike_brand_id", :null => false
      t.integer  "bike_model_id", :null => false
      t.string   "color"
      t.integer  "bike_style_id", :null => false
      t.float    "seat_tube_height"
      t.float    "top_tube_length"
      t.integer  "wheel_size"
      t.float    "value"
      t.string   "bike_condition_id", :null => false
      t.integer  "bike_status_id", :null => false
      t.timestamps
    end
  end
end
