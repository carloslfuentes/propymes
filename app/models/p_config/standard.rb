module PConfig
  class Standard < ActiveRecord::Base
    belongs_to :boot_variable
  end
end

