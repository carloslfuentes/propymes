class AddUnidadFiscalToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :unidad_fiscal, :string
  end

  def self.down
    remove_column :services, :unidad_fiscal
  end
end
