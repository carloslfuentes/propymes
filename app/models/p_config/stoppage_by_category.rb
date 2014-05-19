module PConfig
  class StoppageByCategory < ActiveRecord::Base
    default_value_for :is_enabled, true
    
    scope :is_enabled, where("is_enabled = ?",true)
  end
end

