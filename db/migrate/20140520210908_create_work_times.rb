class CreateWorkTimes < ActiveRecord::Migration
  def change
    create_table :work_times do |t|
      t.string :name
      t.string :first_hour
      t.string :last_hour
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.timestamps
    end
  end
end
