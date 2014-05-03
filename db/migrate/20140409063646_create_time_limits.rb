class CreateTimeLimits < ActiveRecord::Migration
  def self.up
    create_table :time_limits do |t|
      t.string :name
      t.integer :user_id
      t.date :start_date
      t.date :end_date
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :time_limits
  end
end
