class ActsAsLoggableMigration < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.references :loggable, :polymorphic => true
      t.references :logger, :polymorphic => true

      t.string :context, :limit => 128

      t.datetime "start_date", :null => false
      t.datetime "end_date", :null => false

      t.text :description, :default => ""
      t.references :log_action, :polymorphic => true

      t.timestamps
    end

    add_index :logs, [:loggable_id, :loggable_type, :context]
  end

  def self.down
    drop_table :logs
  end
end

