class AddStationIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :station_id, :integer
  end

  def self.down
    remove_column :users, :station_id
  end
end
