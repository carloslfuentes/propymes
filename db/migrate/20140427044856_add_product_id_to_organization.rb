class AddProductIdToOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :product_id, :integer
    add_column :clients, :product_id, :integer
  end

  def self.down
    remove_column :organizations, :product_id
    remove_column :clients, :product_id
  end
end
