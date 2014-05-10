class AddIpStationToStation < ActiveRecord::Migration
  def self.up
    add_column :stations, :ip_station, :string
  end

  def self.down
    remove_column :stations, :ip_station
  end
end
