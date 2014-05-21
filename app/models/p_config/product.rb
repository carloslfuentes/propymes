module PConfig
  class Product < ActiveRecord::Base
    belongs_to :product_type
    default_value_for :is_enabled, true
  end
end
