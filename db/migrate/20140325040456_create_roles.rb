class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles, :force => true do |t|
      t.string  :title
      t.integer :user_id
      t.boolean :is_enabled
      t.integer :profile_id
    end
    add_index "roles", ["profile_id"], :name => "index_roles_on_profile_id"
    add_index "roles", ["title"], :name => "index_roles_on_title"
    add_index "roles", ["user_id"], :name => "index_roles_on_user_id"
  end

  def self.down
    drop_table :roles
  end
end
