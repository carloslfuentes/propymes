class AddTargetPieceToWorkingDay < ActiveRecord::Migration
  def self.up
    add_column :working_days, :target_pieces, :integer
    add_column :working_day_logs, :target_pieces, :integer
  end
  
  def self.down
    remove_column :working_days, :target_pieces
    remove_column :working_day_logs, :target_pieces
  end
end
