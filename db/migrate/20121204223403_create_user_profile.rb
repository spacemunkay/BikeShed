class CreateUserProfile < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer "user_id", :null => false
      t.integer "bike_id"
      t.string "first_name"
      t.string "last_name"
      t.string "addrStreet1"
      t.string "addrStreet2"
      t.string "addrCity"
      t.string "addrState"
      t.string "addrZip"
      t.string "phone"
      t.string "email"
      t.timestamps
    end
  end

end
