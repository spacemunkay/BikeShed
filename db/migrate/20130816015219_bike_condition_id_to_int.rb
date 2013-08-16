class BikeConditionIdToInt < ActiveRecord::Migration
  def up
    #for Postgres
    connection.execute(%q{
      alter table bikes
      alter column bike_condition_id
      type integer using cast(bike_condition_id as integer)
    })
  end

  def down
    #you really don't want to go back
    change_column :bikes, :bike_condition_id, :string
  end
end
