class AddStartTimeToWd < ActiveRecord::Migration
  def self.up
    add_column :working_days, :start_time, :time
    add_column :working_day_logs, :start_time, :time
    add_column :working_days, :end_time, :time
    add_column :working_day_logs, :end_time, :time
    change_column :working_days, :average_piece, :time
    change_column :working_day_logs, :average_piece, :time
  end
  
  def self.down
    remove_column :working_days, :start_time
    remove_column :working_day_logs, :start_time
    remove_column :working_days, :end_time
    remove_column :working_day_logs, :end_time
    change_column :working_days, :average_piece, :string
    change_column :working_day_logs, :average_piece, :string
  end
end
