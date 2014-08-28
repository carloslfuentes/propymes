class CreateLineSets < ActiveRecord::Migration
  def self.up
    create_table :line_sets do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :line_sets
  end
end
