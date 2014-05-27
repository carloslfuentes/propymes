class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string :name
      t.string :description
      t.float :cost_per_unit
      t.boolean :is_enabled, :default => true
      t.timestamps
    end
  end
end
