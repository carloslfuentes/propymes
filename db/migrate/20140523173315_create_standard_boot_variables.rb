class CreateStandardBootVariables < ActiveRecord::Migration
  def change
    create_table :standard_boot_variables do |t|
      t.integer :standard_id
      t.integer :boot_variable_id
      t.timestamps
    end
  end
end
