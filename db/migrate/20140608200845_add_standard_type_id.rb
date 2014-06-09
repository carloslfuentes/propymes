class AddStandardTypeId < ActiveRecord::Migration
  def up
    add_column :stations, :standard_type_id, :integer
    add_column :standards, :standard_type_id, :integer
    add_column :working_days, :standard_type_id, :integer
    add_column :working_day_logs, :standard_type_id, :integer
    add_column :standards, :product_id, :integer
  end

  def down
    remove_column :stations, :standard_type_id
    remove_column :standards, :standard_type_id
    remove_column :working_days, :standard_type_id
    remove_column :working_day_logs, :standard_type_id
    remove_column :standards, :product_id
  end
end
