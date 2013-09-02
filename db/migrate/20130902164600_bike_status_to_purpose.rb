class BikeStatusToPurpose < ActiveRecord::Migration
  def change
    rename_column :bikes, :bike_status_id, :bike_purpose_id
    rename_column :bike_statuses, :status, :purpose
    rename_table :bike_statuses, :bike_purposes
  end
end
