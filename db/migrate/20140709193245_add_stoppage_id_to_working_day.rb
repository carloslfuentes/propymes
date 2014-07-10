class AddStoppageIdToWorkingDay < ActiveRecord::Migration
  def self.up
    add_column :working_days, :stoppage_id, :integer
    add_column :working_day_logs, :stoppage_id, :integer
  end
  def self.down
    remove_column :working_days, :stoppage_id
    remove_column :working_day_logs, :stoppage_id
  end
end
