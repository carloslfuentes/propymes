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

ActiveRecord::Schema.define(:version => 20140501220926) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "colonia"
    t.string   "city"
    t.string   "state"
    t.integer  "phone"
    t.string   "email"
    t.integer  "zip_code"
    t.integer  "user_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.boolean  "is_default",      :default => false
    t.boolean  "is_fiscal",       :default => false
    t.integer  "contry_id"
    t.integer  "state_id"
    t.string   "fiscal_location"
    t.string   "regimen"
    t.string   "internal_number"
  end

  create_table "assistant_medics", :force => true do |t|
    t.integer  "assistant_id"
    t.integer  "medic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attaches", :force => true do |t|
    t.string   "name_file"
    t.integer  "version"
    t.string   "path"
    t.integer  "object_id"
    t.string   "document_type"
    t.string   "directory"
    t.string   "type_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.datetime "date_cite"
    t.integer  "period_time"
    t.string   "custom_period_time"
    t.string   "description"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "send_notification"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.boolean  "is_enabled",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rfc"
    t.string   "external_code"
    t.integer  "product_id"
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

  create_table "consult_services", :force => true do |t|
    t.integer  "consult_id"
    t.integer  "service_id"
    t.decimal  "sub_total",  :precision => 15, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consults", :force => true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.integer  "patient_id"
    t.integer  "cite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "sub_total",   :precision => 15, :scale => 3
    t.decimal  "tax",         :precision => 15, :scale => 3
    t.decimal  "total",       :precision => 15, :scale => 3
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "external_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.date     "date"
    t.string   "format",                  :limit => 64
    t.string   "medic_id"
    t.string   "patient_id"
    t.string   "rfc",                     :limit => 64
    t.string   "street"
    t.string   "number",                  :limit => 32
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "address4"
    t.string   "address5"
    t.string   "address6"
    t.string   "city",                    :limit => 128
    t.integer  "state_id"
    t.integer  "country_id"
    t.string   "zip_code",                :limit => 64
    t.text     "comments"
    t.string   "organization_rfc"
    t.string   "organization_street"
    t.string   "organization_number"
    t.string   "organization_address1"
    t.string   "organization_address2"
    t.string   "organization_address3"
    t.string   "organization_address4"
    t.string   "organization_address5"
    t.string   "organization_address6"
    t.string   "organization_zip_code"
    t.string   "organization_city"
    t.integer  "organization_state_id"
    t.integer  "organization_country_id"
    t.decimal  "amount_sub_total",                       :precision => 15, :scale => 3
    t.decimal  "amount_tax1",                            :precision => 15, :scale => 3
    t.decimal  "amount_tax2",                            :precision => 15, :scale => 3
    t.decimal  "amount_tax3",                            :precision => 15, :scale => 3
    t.decimal  "amount_total",                           :precision => 15, :scale => 3
    t.decimal  "amount_due",                             :precision => 15, :scale => 3
    t.decimal  "amount_paid",                            :precision => 15, :scale => 3
    t.integer  "service_id"
    t.integer  "consult_id"
    t.string   "certified_number"
    t.text     "stamp"
    t.text     "original_chain"
    t.string   "document_type",           :limit => 32
    t.string   "uuid",                    :limit => 256
    t.string   "certified_number_sat",    :limit => 256
    t.string   "stamp_sat",               :limit => 512
    t.string   "folio_series",            :limit => 10
    t.integer  "folio"
    t.date     "canceled_date"
    t.boolean  "cancelled",                                                             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "insurance_id"
    t.integer  "payment_method_id"
    t.string   "regimen"
    t.string   "fiscal_location"
    t.string   "string1"
    t.string   "string2"
    t.string   "string3"
    t.string   "string4"
  end

  create_table "insurances", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "is_active",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_records", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "user_id"
    t.integer  "consult_id"
    t.float    "weight"
    t.integer  "year_old"
    t.float    "height"
    t.float    "temperature"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medicaments", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "organization_id"
    t.string   "external_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medicines", :force => true do |t|
    t.string   "medicine"
    t.string   "dose"
    t.text     "description"
    t.integer  "prescription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.boolean  "is_enabled",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rfc"
    t.string   "external_code"
    t.integer  "product_id"
  end

  create_table "patient_insurances", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "insurance_id"
    t.string   "folio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "name"
    t.string   "last_name_p"
    t.string   "last_name_m"
    t.integer  "age"
    t.date     "date_birth"
    t.boolean  "is_active",   :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.string   "rfc"
  end

  create_table "payment_methods", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_active",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "document_id"
    t.decimal  "payment",           :precision => 15, :scale => 3
    t.integer  "payment_method_id"
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

  create_table "prescriptions", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "user_id"
    t.integer  "consult_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "product_type"
    t.integer  "quantity"
    t.boolean  "is_active",                                   :default => true
    t.decimal  "cost",         :precision => 15, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rate_services", :force => true do |t|
    t.string   "name"
    t.integer  "service_id"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.decimal  "cost",            :precision => 15, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "services", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "description",     :limit => 512
    t.boolean  "is_active",                                                     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost",                           :precision => 15, :scale => 3
    t.string   "unidad_fiscal"
    t.boolean  "tax_includes",                                                  :default => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "external_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxes", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_limits", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",       :default => true
    t.integer  "organization_id"
    t.datetime "next_check"
    t.integer  "number_sessions"
  end

  create_table "users", :force => true do |t|
    t.boolean  "is_medic",                          :default => false
    t.boolean  "is_system_user",                    :default => false
    t.boolean  "is_manager",                        :default => false
    t.boolean  "is_assistant",                      :default => false
    t.integer  "organization_id"
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
    t.string   "rfc"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token"

end
