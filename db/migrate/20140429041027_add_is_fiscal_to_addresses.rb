class AddIsFiscalToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :is_fiscal, :boolean, :default=>false
    remove_column :documents, :payment_method
    add_column :documents, :payment_method_id, :integer
    add_column :documents, :regimen, :string
    add_column :documents, :fiscal_location, :string
    add_column :documents, :string1, :string
    add_column :documents, :string2, :string
    add_column :documents, :string3, :string
    add_column :documents, :string4, :string
  end

  def self.down
    remove_column :addresses, :is_fiscal
    remove_column :documents, :payment_method_id
    add_column :documents, :payment_method, :integer
    remove_column :documents, :regimen
    remove_column :documents, :fiscal_location
    remove_column :documents, :string1
    remove_column :documents, :string2
    remove_column :documents, :string3
    remove_column :documents, :string4
  end
end
