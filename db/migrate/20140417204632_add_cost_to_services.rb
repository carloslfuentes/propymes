class AddCostToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :cost, :decimal, :precision => 15, :scale => 3
  end

  def self.down
    remove_column :services, :cost
  end
end
