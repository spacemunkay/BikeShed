# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121104211300) do


# create_table "team_memberships", :force => true do |t|
#   t.integer  "user_id",    :null => false
#   t.integer  "team_id",    :null => false
#   t.datetime "created_at", :null => false
#   t.datetime "updated_at", :null => false
# end

# add_index "team_memberships", ["team_id"], :name => "index_team_memberships_on_team_id"
# add_index "team_memberships", ["user_id"], :name => "index_team_memberships_on_user_id"

# create_table "teams", :force => true do |t|
#   t.string  "name",         :default => "",    :null => false
#   t.integer "max_members",  :default => 16,    :null => false
#   t.integer "captain_id",                      :null => false
#   t.boolean "private_team", :default => false, :null => false
# end

# add_index "teams", ["captain_id"], :name => "index_teams_on_captain_id"
# add_index "teams", ["name"], :name => "index_teams_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "nickname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
