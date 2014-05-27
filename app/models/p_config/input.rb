module PConfig
  class Input < ActiveRecord::Base
    has_many :standard_inputs, :dependent => :delete_all
    has_many :standards, :through => :standard_inputs
    
    scope :is_enabled, where(:is_enabled=>true)
  end
end
