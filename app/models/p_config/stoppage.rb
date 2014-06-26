module PConfig
  class Stoppage < ActiveRecord::Base
    default_value_for :is_enabled, true
  end
end
