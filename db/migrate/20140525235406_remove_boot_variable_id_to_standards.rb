class RemoveBootVariableIdToStandards < ActiveRecord::Migration
  def up
    remove_column :standards, :boot_variable_id
  end

  def down
    add_column :standards, :boot_variable_id, :integer
  end
end
