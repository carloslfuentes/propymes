class CreateStationUsers < ActiveRecord::Migration
  def self.up
    create_table :station_users do |t|
      t.integer :station_id
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :station_users
  end
end
