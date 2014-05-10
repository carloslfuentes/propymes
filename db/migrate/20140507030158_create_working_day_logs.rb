class CreateWorkingDayLogs < ActiveRecord::Migration
  def self.up
    create_table :working_day_logs do |t|
      t.integer :working_day_log_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :working_day_logs
  end
end
