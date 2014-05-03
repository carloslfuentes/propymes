class CreatePrescriptions < ActiveRecord::Migration
  def self.up
    create_table :prescriptions do |t|
      t.integer :patient_id
      t.integer :user_id
      t.integer :consult_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :prescriptions
  end
end
