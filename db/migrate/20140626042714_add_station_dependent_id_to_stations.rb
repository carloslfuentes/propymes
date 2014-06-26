class AddStationDependentIdToStations < ActiveRecord::Migration
  def self.up
    add_column :stations, :station_dependent_id, :integer
    add_column :working_days, :station_dependent_id, :integer
    add_column :working_day_logs, :station_dependent_id, :integer
  end
  def self.down
    remove_column :stations, :station_dependent_id
    remove_column :working_days, :station_dependent_id
    remove_column :working_day_logs, :station_dependent_id
  end
end
