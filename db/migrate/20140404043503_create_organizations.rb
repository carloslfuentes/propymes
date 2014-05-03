class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.string :description 
      t.integer :user_id
      t.boolean  :is_enabled, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
