class AddTimezonesToLogs < ActiveRecord::Migration
  def up
    change_table :logs do |t|
      t.change :start_date, :timestamptz
      t.change :end_date, :timestamptz
    end
  end

  def down
    change_table :logs do |t|
      t.change :start_date, :timestamp
      t.change :end_date, :timestamp
    end
  end
end
