class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :machinery
      t.string :time_total_workday
      t.boolean :is_enabled, :default => false
      t.string :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
