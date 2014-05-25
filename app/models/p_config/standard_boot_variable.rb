module PConfig
  class StandardBootVariable < ActiveRecord::Base
    belongs_to :standard
    belongs_to :boot_variable
  end
end
