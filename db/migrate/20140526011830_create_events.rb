class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :station_id
      t.integer :stoppage_by_categories_id
      t.integer :stoppage_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
