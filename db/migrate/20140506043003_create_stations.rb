class CreateStations < ActiveRecord::Migration
  def self.up
    create_table :stations do |t|
      t.string :name
      t.integer :product_id
      t.integer :standard_id
      t.string :description
      t.boolean :is_enabled, :default=>true
      t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end
end
