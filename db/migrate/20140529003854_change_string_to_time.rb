class ChangeStringToTime < ActiveRecord::Migration
  def up
    change_column :work_times, :first_hour, :time
    change_column :work_times, :last_hour, :time
    change_column :stoppages, :time, :time
    change_column :boot_variables, :time, :time
  end

  def down
    change_column :work_times, :first_hour, :string
    change_column :work_times, :last_hour, :string
    change_column :stoppages, :time, :string
    change_column :boot_variables, :time, :string
  end
end
