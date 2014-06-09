module PConfig
  class Standard < ActiveRecord::Base
    
    has_many :standard_boot_variables, :dependent => :delete_all
    has_many :boot_variables, :through => :standard_boot_variables
    
    belongs_to :product
    
    has_many :standard_inputs, :dependent => :delete_all
    has_many :inputs, :through => :standard_inputs
    has_many :workin_days
    accepts_nested_attributes_for :standard_boot_variables, :standard_inputs
    
  end
end

