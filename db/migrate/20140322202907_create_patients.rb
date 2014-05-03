class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.string :last_name_p
      t.string :last_name_m
      t.integer :age
      t.date :date_birth
      t.boolean :is_active, :default=>true
      t.timestamps
    end
  end
end
