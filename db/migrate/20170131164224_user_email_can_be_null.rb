class UserEmailCanBeNull < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :email, :string, default: nil, null: true
    end

    User.where(email: '').update_all(email: nil)
  end

  def down
    change_table :users do |t|
      t.change :email, :string, default: '', null: false
    end
  end
end
