class CreateStandards < ActiveRecord::Migration
  def self.up
    create_table :standards do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :standards
  end
end
