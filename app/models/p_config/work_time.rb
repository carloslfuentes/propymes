module PConfig
  class WorkTime < ActiveRecord::Base
    default_value_for :first_hour, "00:00"
    default_value_for :last_hour, "00:00"
    default_value_for :monday, true
    default_value_for :tuesday, true
    default_value_for :wednesday, true
    default_value_for :thursday, true
    default_value_for :friday, true
    
    #Return total hour
    def self.total_hours
      @work_time = PConfig::WorkTime.first
      return @work_time.last_hour - @work_time.first_hour
    end
    
    #Example
    # time = 7683
    # hours = time/3600.to_i
    # minutes = (time/60 - hours * 60).to_i
    # seconds = (time - (minutes * 60 + hours * 3600))
    
  end
end
