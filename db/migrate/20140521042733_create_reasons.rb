class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :name
      t.string :color
      t.string :description
      t.boolean :is_enabled
      t.timestamps
    end
  end
end
