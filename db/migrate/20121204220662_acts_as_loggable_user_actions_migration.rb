class ActsAsLoggableUserActionsMigration < ActiveRecord::Migration

  def self.up
    create_table :user_actions do |t|
      t.string :action, :limit => 128, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_actions
  end

end

