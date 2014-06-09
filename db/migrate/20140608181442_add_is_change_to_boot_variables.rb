class AddIsChangeToBootVariables < ActiveRecord::Migration
  def self.up
    add_column :boot_variables, :is_change, :boolean, :default=>false
  end
  def self.down
    remove_column :boot_variables, :is_change
  end
end
