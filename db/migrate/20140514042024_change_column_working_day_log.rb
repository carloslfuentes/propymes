class ChangeColumnWorkingDayLog < ActiveRecord::Migration
  def up
    remove_column :working_day_logs, :working_day_log_id
    add_column :working_day_logs, :working_day_id, :integer
  end

  def down
    remove_column :working_day_logs, :working_day_id
    add_column :working_day_logs, :working_day_log_id, :integer
  end
end
