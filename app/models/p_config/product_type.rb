module PConfig
  class ProductType < ActiveRecord::Base
    scope :is_enabled, where(:is_enabled=>true)
  end
end
