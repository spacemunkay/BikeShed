class AlterUser < ActiveRecord::Migration
  def change
    remove_column :users, :user_role_id
  end
end
