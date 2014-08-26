class AddTypeOfProductionToStation < ActiveRecord::Migration
  def self.up
    add_column :stations,:type_of_production, :string
  end
  
  def self.down
    remove_column :stations,:type_of_production
  end
end
