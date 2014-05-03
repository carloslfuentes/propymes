class AddContryIdToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :contry_id, :integer
    add_column :addresses, :state_id, :integer
  end

  def self.down
    remove_column :addresses, :contry_id
    remove_column :addresses, :state_id
  end
end
