class CreateBikeModels < ActiveRecord::Migration
  def change
    create_table :bike_models do |t|
      t.string "model", :null => false
      t.integer "bike_brand_id", :null => false
      #t.timestamps
    end
  end
end
