class AddOrganizationIdToTimeLimit < ActiveRecord::Migration
  def self.up
    add_column :time_limits, :organization_id, :integer
    add_column :time_limits, :next_check, :datetime
    add_column :time_limits, :number_sessions, :integer
  end

  def self.down
    remove_column :time_limits, :organization_id
    remove_column :time_limits, :next_check
    remove_column :time_limits, :number_sessions
  end
end
