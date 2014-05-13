class CreateBootVariables < ActiveRecord::Migration
  def change
    create_table :boot_variables do |t|
      t.string :name
      t.integer :product_id
      t.integer :station_id
      t.string :description
      t.string :time
      t.boolean :is_enabled, :default=>true
      t.timestamps
    end
  end
end
