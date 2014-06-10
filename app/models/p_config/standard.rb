module PConfig
  class Standard < ActiveRecord::Base
    
    has_many :standard_boot_variables, :dependent => :delete_all
    has_many :boot_variables, :through => :standard_boot_variables
    
    belongs_to :product
    
    has_many :standard_inputs, :dependent => :delete_all
    has_many :inputs, :through => :standard_inputs
    has_many :workin_days
    belongs_to :standard_type
    accepts_nested_attributes_for :standard_boot_variables, :standard_inputs
    validate :uniqueness_product_and_standartd_type
    
    def uniqueness_product_and_standartd_type
      if (self.product_id_changed? || self.standard_type_id_changed?) && PConfig::Standard.find_by_product_id_and_standard_type_id(self.product_id, self.standard_type_id).present?
        errors.add :uniqueness, "No se debe repetir Proceso y Producto"
        return false
      end
      return true
    end
  end
end

