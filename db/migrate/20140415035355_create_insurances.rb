class CreateInsurances < ActiveRecord::Migration
  def self.up
    create_table :insurances do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.integer :organization_id
      t.boolean :is_active, :default=>true
      t.timestamps
    end
  end

  def self.down
    drop_table :insurances
  end
end
