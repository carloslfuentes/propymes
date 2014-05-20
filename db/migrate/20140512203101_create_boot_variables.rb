class CreateBootVariables < ActiveRecord::Migration
  def change
    create_table :boot_variables do |t|
      t.string :name
      t.string :description
      t.string :time
      t.boolean :is_enabled, :default=>true
      t.timestamps
    end
  end
end
