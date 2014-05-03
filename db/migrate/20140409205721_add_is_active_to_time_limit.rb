class AddIsActiveToTimeLimit < ActiveRecord::Migration
  def self.up
    add_column :time_limits, :is_active, :boolean, :default => true
  end

  def self.down
    remove_column :time_limits, :organization_id
  end
end
