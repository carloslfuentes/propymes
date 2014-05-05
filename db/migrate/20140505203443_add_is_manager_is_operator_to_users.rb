class AddIsManagerIsOperatorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_manager, :boolean, :default => false
    add_column :users, :is_operator, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_manager
    remove_column :users, :is_operator
  end
end
