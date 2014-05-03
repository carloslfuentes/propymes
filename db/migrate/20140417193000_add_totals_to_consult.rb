class AddTotalsToConsult < ActiveRecord::Migration
  def self.up
    add_column :consults, :sub_total, :decimal, :precision => 15, :scale => 3
    add_column :consults, :tax, :decimal, :precision => 15, :scale => 3
    add_column :consults, :total, :decimal, :precision => 15, :scale => 3
  end

  def self.down
    remove_column :consults, :sub_total
    remove_column :consults, :tax
    remove_column :consults, :total
  end
end
