class ActsAsLoggableTransactionActionsMigration < ActiveRecord::Migration

  def self.up
    create_table :transaction_actions do |t|
      t.string :action, :limit => 128, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :transaction_actions
  end

end

