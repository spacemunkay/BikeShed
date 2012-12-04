class ActsAsLoggableBikeActionsMigration < ActiveRecord::Migration

  def self.up
    create_table :bike_actions do |t|
      t.string :action, :limit => 128
      t.timestamps
    end
  end

  def self.down
    drop_table :bike_actions
  end

end

