class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.integer :product_type_id
      t.string :description
      t.boolean :is_enabled, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
