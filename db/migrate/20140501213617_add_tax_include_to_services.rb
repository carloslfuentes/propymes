class AddTaxIncludeToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :tax_includes, :boolean, :default=>false
    add_column :addresses, :fiscal_location, :string
    add_column :addresses, :regimen, :string
    add_column :addresses, :internal_number, :string
  end

  def self.down
    remove_column :services, :tax_includes
    remove_column :addresses, :fiscal_location
    remove_column :addresses, :regimen
    remove_column :addresses, :internal_number
  end
end
