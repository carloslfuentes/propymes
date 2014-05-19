class CreateStoppages < ActiveRecord::Migration
  def change
    create_table :stoppages do |t|
      t.string :name
      t.integer :category_id
      t.string :time
      t.string :solve
      t.timestamps
    end
  end
end
