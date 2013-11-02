class ChangeBikeShopId < ActiveRecord::Migration
  # We don't use change_column because we have arbitrary strings we
  # need to strip the characters from to make the integer values
  def up
    bikes = Bike.all
    remove_column :bikes, :shop_id
    add_column :bikes, :shop_id, :integer, :unique => true

    # deconflict shop ids
    bikes.each do |bike|
      new_id = bike.shop_id.gsub(/[^\d]/, '').to_i rescue 1
      while bikes.map(&:shop_id).include? new_id
        new_id += 1
      end
      bike.update_attribute(:shop_id, new_id)
    end
  end

  def down
    change_column :bikes, :shop_id, :string
  end
end
