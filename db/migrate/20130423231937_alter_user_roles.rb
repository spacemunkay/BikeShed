class AlterUserRoles < ActiveRecord::Migration
  def up
    rename_table :user_roles, :user_role_joins
    change_table :user_role_joins do |t|
      t.rename :role, :role_id
      #t.change :role_id, :integer
    end
    #for Postgres
    connection.execute(%q{
      alter table user_role_joins
      alter column role_id
      type integer using cast(role_id as integer)
    })
  end

  def down
    rename_table :user_role_joins, :user_roles
    change_table :user_role_joins do |t|
      t.rename :role_id, :role
      t.change :role_id, :string
    end
  end
end
