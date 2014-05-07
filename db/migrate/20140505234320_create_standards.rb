class CreateStandards < ActiveRecord::Migration
  def self.up
    create_table :standards do |t|
      t.string :name
      t.string :description
      t.string :unit_type
      t.integer :item_number
      t.timestamps
    end
  end

  def self.down
    drop_table :standards
  end
end
