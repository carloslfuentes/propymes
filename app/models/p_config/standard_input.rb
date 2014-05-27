module PConfig
  class StandardInput < ActiveRecord::Base
    belongs_to :standard
    belongs_to :input
  end
end
