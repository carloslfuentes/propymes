module PConfig
  class WorkTime < ActiveRecord::Base
    default_value_for :monday, true
    default_value_for :tuesday, true
    default_value_for :wednesday, true
    default_value_for :thursday, true
    default_value_for :friday, true
  end
end
