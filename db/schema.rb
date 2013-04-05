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

ActiveRecord::Schema.define(:version => 20130405012238) do

  create_table "bike_actions", :force => true do |t|
    t.string   "action",     :limit => 128, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "bike_brands", :force => true do |t|
    t.string "brand"
  end

  create_table "bike_conditions", :force => true do |t|
    t.string   "condition",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bike_models", :force => true do |t|
    t.string  "model",         :null => false
    t.integer "bike_brand_id", :null => false
  end

  create_table "bike_statuses", :force => true do |t|
    t.string   "status",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bike_styles", :force => true do |t|
    t.string   "style",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bikes", :force => true do |t|
    t.string   "serial_number"
    t.integer  "bike_brand_id",     :null => false
    t.integer  "bike_model_id",     :null => false
    t.string   "color"
    t.integer  "bike_style_id",     :null => false
    t.float    "seat_tube_height"
    t.float    "top_tube_length"
    t.integer  "wheel_size"
    t.float    "value"
    t.string   "bike_condition_id", :null => false
    t.integer  "bike_status_id",    :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "shop_id"
  end

  add_index "bikes", ["shop_id"], :name => "index_bikes_on_shop_id", :unique => true

  create_table "customers", :force => true do |t|
    t.string "first_name",  :null => false
    t.string "last_name",   :null => false
    t.string "addrStreet1"
    t.string "addrStreet2"
    t.string "addrCity"
    t.string "addrState"
    t.string "addrZip"
    t.string "phone"
    t.string "email"
  end

  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true
  add_index "customers", ["phone"], :name => "index_customers_on_phone", :unique => true

  create_table "logs", :force => true do |t|
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.integer  "logger_id"
    t.string   "logger_type"
    t.string   "context",         :limit => 128
    t.datetime "start_date",                                     :null => false
    t.datetime "end_date",                                       :null => false
    t.text     "description",                    :default => ""
    t.integer  "log_action_id"
    t.string   "log_action_type"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "logs", ["loggable_id", "loggable_type", "context"], :name => "index_logs_on_loggable_id_and_loggable_type_and_context"

  create_table "task_lists", :force => true do |t|
    t.integer "item_id",   :null => false
    t.string  "item_type", :null => false
    t.string  "name",      :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer "task_list_id", :null => false
    t.string  "task",         :null => false
    t.text    "notes"
    t.boolean "done"
  end

  create_table "transaction_actions", :force => true do |t|
    t.string   "action",     :limit => 128, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "vendor_id",     :null => false
    t.integer  "customer_id",   :null => false
    t.string   "customer_type", :null => false
    t.integer  "bike_id"
    t.integer  "amount",        :null => false
    t.string   "item",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_actions", :force => true do |t|
    t.string   "action",     :limit => 128, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "addrStreet1"
    t.string   "addrStreet2"
    t.string   "addrCity"
    t.string   "addrState"
    t.string   "addrZip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.integer  "user_role_id",           :default => 1,  :null => false
    t.integer  "bike_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "nickname"
  end

  add_index "users", ["bike_id"], :name => "index_users_on_bike_id", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
