class AddModelToBike < ActiveRecord::Migration
  def change
    add_column :bikes, :model, :string
    change_column :bikes, :bike_model_id, :integer, :null => true
    Bike.all.each do |bike|
      bike.update_attribute(:model, BikeModel.find_by_id(bike['bike_model_id']).model )
    end
  end
end
