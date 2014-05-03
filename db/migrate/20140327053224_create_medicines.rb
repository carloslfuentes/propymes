class CreateMedicines < ActiveRecord::Migration
  def self.up
    create_table :medicines do |t|
      t.string :medicine
      t.string :dose
      t.text :description
      t.integer :prescription_id
      t.timestamps
    end
  end

  def self.down
    drop_table :medicines
  end
end
