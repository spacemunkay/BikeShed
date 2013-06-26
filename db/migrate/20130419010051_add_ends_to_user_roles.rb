class AddEndsToUserRoles < ActiveRecord::Migration
  def change
    add_column(:user_roles, :ends, :timestamp)
    add_column(:user_roles, :user_id, :integer)
  end
end
