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

ActiveRecord::Schema.define(:version => 20140520210908) do

  create_table "boot_variables", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "time"
    t.boolean  "is_enabled",  :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "configuration_mailers", :force => true do |t|
    t.string   "name"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "delivery_method"
    t.string   "address"
    t.string   "port"
    t.string   "domain"
    t.string   "user_name"
    t.string   "password"
    t.string   "authentication"
    t.string   "enable_starttls_auto"
    t.boolean  "is_active",            :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuration_values", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "options"
    t.string   "option_type"
    t.string   "description"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "options"
    t.string   "option_type"
    t.string   "description"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "last_name"
    t.date     "date_birth"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "description"
    t.boolean  "is_enabled",  :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "product_type_id"
    t.string   "description"
    t.boolean  "is_enabled",      :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "roles", :force => true do |t|
    t.string  "title"
    t.integer "user_id"
    t.boolean "is_enabled"
    t.integer "profile_id"
  end

  add_index "roles", ["profile_id"], :name => "index_roles_on_profile_id"
  add_index "roles", ["title"], :name => "index_roles_on_title"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "standards", :force => true do |t|
    t.string   "name"
    t.integer  "boot_variable_id"
    t.string   "description"
    t.string   "unit_type"
    t.integer  "item_number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "stations", :force => true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.integer  "standard_id"
    t.string   "description"
    t.boolean  "is_enabled",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_station"
  end

  create_table "stoppage_by_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_enabled"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stoppages", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "time"
    t.string   "solve"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "time_limits", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.boolean  "is_active",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.boolean  "is_enabled",                        :default => true
    t.text     "comments"
    t.string   "login",               :limit => 32
    t.string   "email"
    t.string   "language",            :limit => 5
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.integer  "login_count",                       :default => 0
    t.integer  "failed_login_count",                :default => 0
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "startup_module"
    t.string   "session_key"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "perishable_token",                  :default => ""
    t.boolean  "verified",                          :default => false
    t.boolean  "is_manager",                        :default => false
    t.boolean  "is_operator",                       :default => false
    t.integer  "station_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token"

  create_table "work_times", :force => true do |t|
    t.string   "name"
    t.string   "first_hour"
    t.string   "last_hour"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "working_day_logs", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "description"
    t.integer  "working_day_id"
  end

  create_table "working_days", :force => true do |t|
    t.integer  "station_id"
    t.integer  "operator_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "status"
    t.string   "description"
    t.string   "reason"
  end

end
