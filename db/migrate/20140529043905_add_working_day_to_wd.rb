class AddWorkingDayToWd < ActiveRecord::Migration
  def self.up
    add_column :working_days, :disponible_time, :time
    add_column :working_day_logs, :disponible_time, :time
    add_column :working_day_logs, :station_id, :integer
    add_column :working_day_logs, :operator_id, :integer
    add_column :working_day_logs, :status, :string
    add_column :working_day_logs, :reason, :string
    change_column :working_day_logs, :effective_time, :time
    change_column :working_days, :effective_time, :time
    change_column :working_day_logs, :delayed_time, :time
    change_column :working_days, :delayed_time, :time
  end
  
  def self.down
    remove_column :working_days, :disponible_time
    remove_column :working_day_logs, :disponible_time
    remove_column :working_day_logs, :station_id
    remove_column :working_day_logs, :operator_id
    remove_column :working_day_logs, :status
    remove_column :working_day_logs, :reason
    change_column :working_day_logs, :effective_time, :string
    change_column :working_days, :effective_time, :string
    change_column :working_day_logs, :delayed_time, :string
    change_column :working_days, :delayed_time, :string
  end
end
