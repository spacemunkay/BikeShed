class AddRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :role
      t.timestamps
    end
  end
end
