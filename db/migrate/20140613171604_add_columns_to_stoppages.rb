class AddColumnsToStoppages < ActiveRecord::Migration
  def self.up
    remove_column :stoppages, :category_id
    add_column :stoppages, :color, :string
    add_column :stoppages, :is_enabled, :boolean, :default => false
  end
  
  def self.down
    add_column :stoppages, :category_id, :integer
    remove_column :stoppages, :color
    remove_column :stoppages, :is_enabled
  end
end
