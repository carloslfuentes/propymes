module PConfig
  class BootVariable < ActiveRecord::Base
    
    has_many :standard_boot_variables, :dependent => :delete_all
    has_many :standards, :through => :standard_boot_variables
    
    scope :is_enabled, where(:is_enabled=>true)
  end
end
