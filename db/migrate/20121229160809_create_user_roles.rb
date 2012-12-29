class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table(:user_roles) do |t|
      t.string :role
      t.timestamps
    end
  end
end
