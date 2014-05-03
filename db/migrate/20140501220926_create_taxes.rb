class CreateTaxes < ActiveRecord::Migration
  def self.up
    create_table :taxes do |t|
      t.string :name
      t.integer :value
      t.boolean :is_active, :default=>true
      t.timestamps
    end
  end

  def self.down
    drop_table :taxes
  end
end
