class AddOrganizationIdToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :organization_id, :integer
  end

  def self.down
    remove_column :addresses, :organization_id
  end
end
