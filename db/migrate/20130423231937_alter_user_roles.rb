class AlterUserRoles < ActiveRecord::Migration
  def change
    rename_table :user_roles, :user_role_joins
    change_table :user_role_joins do |t|
      t.rename :role, :role_id
      t.remove :id
    end
  end
end
