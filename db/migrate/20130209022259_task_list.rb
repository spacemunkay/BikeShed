class TaskList < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.integer "item_id", :null => false
      t.string "item_type", :null => false
      t.string "name", :null => false
    end
  end
end
