class AddMiceselaneor < ActiveRecord::Migration
  def self.up
    add_column :patients, :rfc, :string
    add_column :users, :rfc, :string
    add_column :organizations, :rfc, :string
    add_column :documents, :insurance_id, :integer
    add_column :addresses, :is_default, :boolean, :default=>false
  end

  def self.down
    remove_column :patients, :rfc
    remove_column :users, :rfc
    remove_column :organizations, :rfc
    remove_column :documents, :insurance_id
    remove_column :addresses, :is_default
  end
end
