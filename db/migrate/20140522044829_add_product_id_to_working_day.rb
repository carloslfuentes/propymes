class AddProductIdToWorkingDay < ActiveRecord::Migration
  def self.up
    add_column :working_days, :product_id, :integer
    add_column :working_day_logs, :product_id, :integer
  end
  
  def self.down
    remove_column :working_days, :product_id
    remove_column :working_day_logs, :product_id
  end
end
