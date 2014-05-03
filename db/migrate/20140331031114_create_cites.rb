class CreateCites < ActiveRecord::Migration
  def self.up
    create_table :cites do |t|
      t.integer :user_id
      t.integer :patient_id
      t.datetime :date_cite
      t.integer :period_time
      t.string :custom_period_time
      t.string :description
      t.boolean :is_active
      t.timestamps
    end
  end

  def self.down
    drop_table :cites
  end
end
