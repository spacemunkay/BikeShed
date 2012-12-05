class CreateBikeModels < ActiveRecord::Migration
  def change
    create_table :bike_models do |t|
      t.integer "bike_brand_id"
      t.string "model"
      t.timestamps
    end
  end
end
