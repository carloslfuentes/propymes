class CreateConfigurationValues < ActiveRecord::Migration
  def self.up
    create_table :configuration_values do |t|
      t.string :name
      t.string :value
      t.string :options
      t.string :option_type
      t.string :description
      t.string :group
      t.timestamps
    end
  end

  def self.down
    drop_table :configuration_values
  end
end
