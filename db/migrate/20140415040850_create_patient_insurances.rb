class CreatePatientInsurances < ActiveRecord::Migration
  def self.up
    create_table :patient_insurances do |t|
      t.integer :patient_id
      t.integer :insurance_id
      t.string :folio
      t.timestamps
    end
  end

  def self.down
    drop_table :patient_insurances
  end
end
