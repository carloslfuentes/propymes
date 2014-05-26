class CreateAccidents < ActiveRecord::Migration
  def change
    create_table :accidents do |t|
      t.integer :station_id
      t.integer :user_id
      t.string  :description
      t.string  :status
      t.boolean :is_active, :default=>true
      t.string  :clasification_type
      t.string  :standby_time 
      t.timestamps
    end
  end
end
