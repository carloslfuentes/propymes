class CreateLineSetStations < ActiveRecord::Migration
  def self.up
    create_table :line_set_stations do |t|
      t.integer :line_set_id
      t.integer :station_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :line_set_stations
  end
end
