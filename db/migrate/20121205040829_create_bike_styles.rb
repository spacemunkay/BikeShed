class CreateBikeStyles < ActiveRecord::Migration
  def change
    create_table :bike_styles do |t|
      t.string "style"
      t.timestamps
    end
  end
end
