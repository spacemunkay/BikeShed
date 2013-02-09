class Task < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer "task_list_id", :null => false
      t.string "task", :null => false
      t.text "notes"
      t.boolean "done"
    end
  end
end
