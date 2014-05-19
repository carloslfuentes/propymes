class AddStatusToWorkingDay < ActiveRecord::Migration
  def self.up
    add_column :working_days, :status, :string
    add_column :working_day_logs, :description, :string
  end

  def self.down
    remove_column :working_days, :status
    remove_column :working_day_logs, :description
  end
end
