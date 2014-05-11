module PConfig
  class Station < ActiveRecord::Base
    belongs_to :product
    belongs_to :standard
    has_many :users
  end
end

