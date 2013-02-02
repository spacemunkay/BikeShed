class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string "first_name", :null => false
      t.string "last_name", :null => false
      t.string "addrStreet1"
      t.string "addrStreet2"
      t.string "addrCity"
      t.string "addrState"
      t.string "addrZip"
      t.string "phone"
      t.string "email"
    end

    add_index :customers, :phone, :unique => true
    add_index :customers, :email, :unique => true
  end

end
