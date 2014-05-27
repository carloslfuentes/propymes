class AddProductionsToWorkingDay < ActiveRecord::Migration
  def self.up
    add_column :working_days, :percentage_production, :float
    add_column :working_day_logs, :percentage_production, :float
    add_column :working_days, :average_piece, :float
    add_column :working_day_logs, :average_piece, :float
    add_column :working_days, :number_piece, :float
    add_column :working_day_logs, :number_piece, :float
    add_column :working_days, :effective_time, :string
    add_column :working_day_logs, :effective_time, :string
    add_column :working_days, :delayed_time, :string
    add_column :working_day_logs, :delayed_time, :string
    add_column :working_days, :cost_production, :float
    add_column :working_day_logs, :cost_production, :float
    add_column :working_days, :standard_id, :integer
    add_column :working_day_logs, :standard_id, :integer
  end
  
  def self.down
    remove_column :working_days, :percentage_production
    remove_column :working_day_logs, :percentage_production
    remove_column :working_days, :average_piece
    remove_column :working_day_logs, :average_piece
    remove_column :working_days, :number_piece
    remove_column :working_day_logs, :number_piece
    remove_column :working_days, :effective_time
    remove_column :working_day_logs, :effective_time
    remove_column :working_days, :delayed_time
    remove_column :working_day_logs, :delayed_time
    remove_column :working_days, :cost_production
    remove_column :working_day_logs, :cost_production
    remove_column :working_days, :standard_id
    remove_column :working_day_logs, :standard_id
  end
end
