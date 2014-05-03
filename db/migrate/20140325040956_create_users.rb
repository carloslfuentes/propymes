class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.boolean  :is_medic,                                                        :default => false
      t.boolean  :is_system_user,                                                  :default => false
      t.boolean  :is_manager,                                                      :default => false
      t.boolean  :is_assistant,                                                    :default => false
      t.integer  :organization_id
      t.boolean  :is_enabled,                                                      :default => true
      t.text     :comments
      t.string   :login,               :limit => 32#,                                                  :null => false
      t.string   :email
      t.string   :language,            :limit => 5#,                                                   #:null => false
      t.string   :crypted_password#,                                                                   #:null => false
      t.string   :password_salt#,                                                                      #:null => false
      t.string   :persistence_token#,                                                                  #:null => false
      t.string   :single_access_token#,                                                                #:null => false
      t.integer  :login_count,                                                     :default => 0#,     #:null => false
      t.integer  :failed_login_count,                                              :default => 0#,     #:null => false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string   :current_login_ip
      t.string   :last_login_ip
      t.string   :startup_module
      t.string   :session_key
      t.integer  :created_by
      t.integer  :updated_by
      t.string   :perishable_token,                                                :default => ""#,    :null => false
      t.boolean  :verified,                                                        :default => false#, :null => false
    end
    add_index "users", ["email"], :name => "index_users_on_email"
    add_index "users", ["login"], :name => "index_users_on_login"
    add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
    add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
    add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token"
  end

  def self.down
    drop_table :users
  end
end
