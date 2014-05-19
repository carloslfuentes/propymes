class AddDescriptionWorkingDay < ActiveRecord::Migration
  def up
    add_column :working_days, :description, :string
    add_column :working_days, :reason, :string
  end

  def down
    remove_column :working_days, :description
    remove_column :working_days, :reason
  end
end
