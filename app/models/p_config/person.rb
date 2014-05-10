module PConfig
  class Person < ActiveRecord::Base
    belongs_to   :user
  end
end

