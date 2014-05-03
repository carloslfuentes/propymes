class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string   :name
      t.string   :description
      t.integer  :user_id
      t.boolean  :is_enabled,    :default => true
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :rfc
      t.string   :external_code
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
