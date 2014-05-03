class CreateAssistantMedics < ActiveRecord::Migration
  def self.up
    create_table :assistant_medics do |t|
      t.integer :assistant_id
      t.integer :medic_id
      t.timestamps
    end
  end

  def self.down
    drop_table :assistant_medics
  end
end
