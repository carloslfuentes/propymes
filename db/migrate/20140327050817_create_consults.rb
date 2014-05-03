class CreateConsults < ActiveRecord::Migration
  def self.up
    create_table :consults do |t|
      t.string :description
      t.integer :user_id
      t.integer :patient_id
      t.integer :cite_id
      t.timestamps
    end
  end

  def self.down
    drop_table :consults
  end
end
