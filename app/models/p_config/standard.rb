module PConfig
  class Standard < ActiveRecord::Base
    
    has_many :standard_boot_variables, :dependent => :delete_all
    has_many :boot_variables, :through => :standard_boot_variables
    
    accepts_nested_attributes_for :standard_boot_variables
  end
end

