module PConfig
  class ProductStation < ActiveRecord::Base
    belongs_to :product
    belongs_to :station
  end
end
