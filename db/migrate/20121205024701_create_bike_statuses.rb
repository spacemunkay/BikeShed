class CreateBikeStatuses < ActiveRecord::Migration
  def change
    create_table :bike_statuses do |t|
      t.string "status", :null => false
      t.timestamps
    end
  end
end
