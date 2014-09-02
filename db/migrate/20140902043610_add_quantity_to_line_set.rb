class AddQuantityToLineSet < ActiveRecord::Migration
  def self.up
  	add_column :line_sets, :quantity, :integer
  end
  def self.down
  	remove_column :line_sets, :quantity
  end
end
