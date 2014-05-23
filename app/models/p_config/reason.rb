module PConfig
  class Reason < ActiveRecord::Base
    default_value_for :is_enabled, true
  end
end
