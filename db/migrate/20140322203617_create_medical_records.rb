class CreateMedicalRecords < ActiveRecord::Migration
  def self.up
    create_table :medical_records do |t|
      t.integer   :patient_id
      t.integer   :user_id
      t.integer   :consult_id
      t.float    :weight
      t.integer   :year_old
      t.float    :height
      t.float    :temperature
      t.string    :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :medical_records
  end
end
