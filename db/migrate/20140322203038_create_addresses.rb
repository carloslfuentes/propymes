class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :colonia
      t.string :city
      t.string :state
      t.integer :phone
      t.string :email
      t.integer :zip_code
      t.integer :user_id
      t.integer :patient_id
      t.timestamps
    end
  end
  def self.down
    drop_table :addresses
  end
end
