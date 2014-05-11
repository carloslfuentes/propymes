class CreateWorkingDays < ActiveRecord::Migration
  def self.up
    create_table :working_days do |t|
      t.integer :station_id
      t.integer :operator_id
      t.timestamps
    end
  end

  def self.down
    drop_table :working_days
  end
end
