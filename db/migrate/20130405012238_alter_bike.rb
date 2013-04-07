class AlterBike < ActiveRecord::Migration
  def up
    add_column(:bikes, :shop_id, :string)
    add_index :bikes, :shop_id, :unique => true
    remove_index :bikes, :column => :serial_number
  end

  def down
    remove_index :bikes, :column => :shop_id
    remove_column(:bikes, :shop_id)
    add_index :bikes, :serial_number, :unique => true
  end
end
