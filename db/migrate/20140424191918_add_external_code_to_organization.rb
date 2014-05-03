class AddExternalCodeToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :external_code, :string
  end

  def self.down
    remove_column :organizations, :external_code
  end
end
