class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :product_type
      t.integer :quantity
      t.boolean :is_active, :default=>true
      t.decimal :cost, :precision => 15, :scale => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
